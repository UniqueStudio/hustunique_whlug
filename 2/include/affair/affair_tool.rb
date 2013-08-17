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
			def insert(title, time, location, content)
				last_nid = @affair_helper.find_last_nid
				now_t = Time.now.to_i.to_s
				t = UtilsBase.split_time(time)
				time_t = Time.new(t.year, t.month, t.day).to_i.to_s
				@db_helper.insert({title: title, time: time, create_time: now_t, modify_time: now_t, timestamp: time_t, content: content, location: location, nid: last_nid + 1, isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s})
			end

			def find_briefs(num)
				result = @db_helper.find_by({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s})
				return if result.nil?
				res = result.sort({timestamp: -1}).limit(Disposition::COMMON_AFFAIR_PAGE_MAX_NUM).skip(@affair_helper.format_page(num)).to_a
				return if res.empty?
				final = []
				res.map {|l| final << AffairBriefs.new(l['time'], l['title'], l['nid'])}
				final
			end

			def active?(nid)
				result = @db_helper.find_one({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s, nid: nid})
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
