#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/config/common_config.rb"
	require "#{MAIN_PATH}include/event/event.rb"
else
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}event#{ASH_SEP}event.rb"
end

module Ash
	module ModuleTool

		EventBriefs = Struct.new(:time, :title, :nid)

		class EventTool

			attr_reader :event, :event_helper, :db_helper
			def initialize
				@event_helper = ExtraDB::EventHelper.new
				@event, @db_helper = @event_helper.event, @event_helper.helper
			end

			public
			def insert(title, time, location, content)
				last_nid = @event_helper.find_last_nid
				now_t = Time.now.to_i.to_s
				t = UtilsBase.split_time(time)
				time_t = Time.new(t.year, t.month, t.day).to_i.to_s
				@db_helper.insert({title: title, time: time, create_time: now_t, modify_time: now_t, timestamp: time_t, content: content, location: location, nid: last_nid + 1, isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s})
			end

			def find_briefs(num)
				result = @db_helper.find_by({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s})
				return if result.nil?
				res = result.sort({timestamp: -1}).limit(Disposition::COMMON_EVENT_PAGE_MAX_NUM).skip(@event_helper.format_page(num)).to_a
				return if res.empty?
				final = []
				res.map {|l| final << EventBriefs.new(l['time'], l['title'], l['nid'])}
				final
			end

			def active?(nid)
				result = @db_helper.find_one({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s, nid: nid})
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
				EventBriefs.new(r['time'], r['title'][0, 10], r['nid'])
			end


		end
	end
end
