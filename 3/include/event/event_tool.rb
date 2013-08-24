#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/event/event.rb"
else
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}event#{ASH_SEP}event.rb"
end

module Ash
	module ModuleTool

		EventBriefs = Struct.new(:time, :title, :nid)
    EventDetBriefs = Struct.new(:time, :title, :nid, :content, :hits)

		class EventTool

			attr_reader :event, :event_helper, :db_helper
			def initialize
				@event_helper = ExtraDB::EventHelper.new
				@event, @db_helper = @event_helper.event, @event_helper.helper
			end

			public
			def insert(title, writer, content)
				last_nid = @event_helper.find_last_nid
				@db_helper.insert({title: title, time: Time.now.to_i.to_s, content: content, nid: last_nid + 1, isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s, writer: writer, hits: 0, origin: ''})
			end

			def find_briefs_by_page(num)
				result = @db_helper.find_by({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s})
				return if result.nil?
				res = result.sort({time: -1}).limit(Disposition::COMMON_EVENT_PAGE_MAX_NUM).skip(@event_helper.num_events(num)).to_a
				return if res.empty?
				final = []
				res.map {|l| final << EventBriefs.new(UtilsBase.format_brief_time(l['time']), l['title'], l['nid'].to_i)}
				final
			end

      def find_det_briefs_by_page(num)
        result = @db_helper.find_by({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s})
        return if result.nil?
        res = result.sort({time: -1}).limit(Disposition::COMMON_EVENT_PAGE_MAX_NUM).skip(@event_helper.num_events(num)).to_a
        return if res.empty?
        final = []
        res.map {|l| final << EventDetBriefs.new(UtilsBase.format_det_time(l['time']), l['title'], l['nid'].to_i, UtilsBase.html_gsub(l['content']), l['hits'].to_i)}
        final
      end

			def active?
				result = @db_helper.find_one({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s, nid: @event.nid})
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
				#EventBriefs.new(r['time'], r['title'][0, 10], r['nid'])
			#end

			def init_event(arg = {})
				arg.map {|key, value| @event.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

		end
	end
end
