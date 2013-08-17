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
			def insert(title, time, location, content)
				last_nid = @summary_helper.find_last_nid
				now_t = Time.now.to_i.to_s
				t = UtilsBase.split_time(time)
				time_t = Time.new(t.year, t.month, t.day).to_i.to_s
				@db_helper.insert({title: title, time: time, create_time: now_t, modify_time: now_t, timestamp: time_t, content: content, location: location, nid: last_nid + 1, isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s})
			end

			def find_briefs(num)
				result = @db_helper.find_by({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s})
				return if result.nil?
				res = result.sort({timestamp: -1}).limit(Disposition::COMMON_SUMMARY_PAGE_MAX_NUM).skip(@summary_helper.format_page(num)).to_a
				return if res.empty?
				final = []
				res.map {|l| final << SummaryBriefs.new(l['time'], l['title'], l['nid'])}
				final
			end

			def active?(nid)
				result = @db_helper.find_one({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s, nid: nid})
				!result.nil?
			end

			def update(nid, title, time, location, content)
				t = UtilsBase.split_time(time)
				time_t = Time.new(t.year, t.month, t.day).to_i.to_s
				@db_helper.update({nid: nid}, {"$set" => {title: title, time: time, timestamp: time_t, modify_time: Time.now.to_i.to_s, content: content, location: location}})['updatedExisting']
			end


		end
	end
end
