#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/summary/summary.rb"
else
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}summary#{ASH_SEP}summary.rb"
end

module Ash
	module ModuleTool

		SummaryBriefs = Struct.new(:time, :title, :nid)

		class SummaryTool

			attr_reader :summary, :summary_helper, :db_helper
			def initialize
				@summary_helper = ExtraDB::SummaryHelper.new
				@summary, @db_helper = @summary_helper.summary, @summary_helper.helper
			end

			public
			def insert(title, writer, content)
				last_nid = @summary_helper.find_last_nid
				@db_helper.insert({title: title, time: Time.now.to_i.to_s, content: content, nid: last_nid + 1, isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s, writer: writer, hits: 0, origin: ''})
			end

			def find_briefs_by_page(num)
				result = @db_helper.find_by({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s})
				return if result.nil?
				res = result.sort({time: -1}).limit(Disposition::COMMON_SUMMARY_PAGE_MAX_NUM).skip(@summary_helper.num_summarys(num)).to_a
				return if res.empty?
				final = []
				res.map {|l| final << SummaryBriefs.new(UtilsBase.format_brief_time(l['time']), l['title'], l['nid'].to_i)}
				final
			end

			def active?
				result = @db_helper.find_one({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s, nid: @summary.nid})
				!result.nil?
			end

			def update(nid, title, writer, content)
				@db_helper.update({nid: nid}, {"$set" => {title: title, writer: writer,content: content}})['updatedExisting']
			end

			#def find_du_briefs(num)
				#[self.find_simple_briefs(num - 1), self.find_simple_briefs(num + 1)]
			#end

			#def find_simple_briefs(num)
				#return if num <= 0
				#r = @db_helper.find_one({nid: num.to_i})
				#return if r.nil?
				#SummaryBriefs.new(r['time'], r['title'][0, 10], r['nid'])
			#end

			def init_summary(arg = {})
				arg.map {|key, value| @summary.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

		end
	end
end
