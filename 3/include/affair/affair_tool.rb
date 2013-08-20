#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/affair/affair.rb"
else
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}affair#{ASH_SEP}affair.rb"
end

module Ash
	module ModuleTool

		AffairBriefs = Struct.new(:time, :title, :nid)

		class AffairTool

			attr_reader :affair, :affair_helper, :db_helper
			def initialize
				@affair_helper = ExtraDB::AffairHelper.new
				@affair, @db_helper = @affair_helper.affair, @affair_helper.helper
			end

			public
			def insert(title, writer, content)
				last_nid = @affair_helper.find_last_nid
				@db_helper.insert({title: title, time: Time.now.to_i.to_s, content: content, nid: last_nid + 1, isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s, writer: writer, hits: 0, origin: ''})
			end

			def find_briefs_by_page(num)
				result = @db_helper.find_by({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s})
				return if result.nil?
				res = result.sort({time: -1}).limit(Disposition::COMMON_AFFAIR_PAGE_MAX_NUM).skip(@affair_helper.num_affairs(num)).to_a
				return if res.empty?
				final = []
				res.map {|l| final << AffairBriefs.new(UtilsBase.format_brief_time(l['time']), l['title'], l['nid'].to_i)}
				final
			end

			def active?
				result = @db_helper.find_one({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s, nid: @affair.nid})
				!result.nil?
			end

			def update(nid, title, time, location, content)
				t = UtilsBase.split_time(time)
				time_t = Time.new(t.year, t.month, t.day).to_i.to_s
				@db_helper.update({nid: nid}, {"$set" => {title: title, time: time, timestamp: time_t, modify_time: Time.now.to_i.to_s, content: content, location: location}})['updatedExisting']
			end

			def find_du_briefs(num)
				[self.find_simple_briefs(num - 1), self.find_simple_briefs(num + 1)]
			end

			def find_simple_briefs(num)
				return if num <= 0
				r = @db_helper.find_one({nid: num.to_i})
				return if r.nil?
				AffairBriefs.new(r['time'], r['title'][0, 10], r['nid'])
			end

			def init_affair(arg = {})
				arg.map {|key, value| @affair.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

		end
	end
end
