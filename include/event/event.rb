#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/db_helper.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}db_helper.rb"
	require "#{Ash::Disposition::SYS_DIR_COMMON}utils_base.rb"
end

module Ash
	module ExtraDB

		class Event

			attr_accessor :id, :title, :fmt_time, :content, :nid, :active, :writer, :hits, :origin
			def initialize(args = {})
				raise EventException, "Event initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end

			def get_binding; binding(); end
		end

		class EventResult

			attr_reader :event
			def initialize(events)
				@event = []
				events = [events] unless events.is_a? Array
				events.map do |event|
					raise EventException, "EventResult initialize argument error" unless event.is_a? Hash
					@event << Event.new(
						id: event['_id'].to_s || nil,
						title: event['title'] || nil,
						fmt_time: event.has_key?('time') ? UtilsBase.format_time(event['time']) : nil,
						content: event['content'] || nil,
						nid: event.has_key?('nid') ? event['nid'].to_i : nil,
						active: event.has_key?('isActive') ? UtilsBase.active?(event['isActive'], Disposition::COMMON_EVENT_IS_ACTIVE) : nil,
						writer: event['writer'] || nil,
						hits: event.has_key?('hits') ? event['hits'].to_i : nil,
						origin: event['origin'] || nil,
					)
				end
			end

			protected
			def active?(act); act == Disposition::COMMON_EVENT_IS_ACTIVE.to_s; end
		end

		class EventHelper
			attr_accessor :event
			attr_reader :helper

			def initialize
				@event_db_name = 'Events'
				@helper = DB::DBHelper.new(@event_db_name)
				@event = Event.new
			end

			def find_by_nid(nid = nil)
				@event.nid = nid unless nid.nil?
				raise EventException, "nid error" unless @event.nid.instance_of? Fixnum
				result = @helper.find_one({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s, nid: @event.nid})
				return if result.nil?
				EventResult.new(result).event.first
			end

			def find_last_nid
				res = @helper.find_by({}).sort({_id: -1}).limit(1).to_a
				res.empty? ? 0 : res.first['nid']
			end

			def num_events(page)
				raise EventException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_EVENT_PAGE_MAX_NUM
			end

			def active_count
				@helper.find_by({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s}).to_a.length
			end

			def hits_increase(nid = nil)
				@event.nid = nid unless nid.nil?
				raise EventException, "hits_increase argument error" unless @event.nid.instance_of? Fixnum
				@helper.update({nid: @event.nid}, {"$inc" => {hits: 1}})['updatedExisting']
			end

			def not_active(nid = nil)
				@event.nid = nid unless nid.nil?
				raise EventException, "not_active argument error" unless @event.nid.instance_of? Fixnum
				@helper.update({nid: @event.nid}, {"$set" => {isActive: Disposition::COMMON_EVENT_NOT_IS_ACTIVE.to_s}})['updatedExisting']
			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				EventResult.new(result.sort(time: -1).limit(nlimit).skip(nskip).to_a)
			end
		end

		class EventException < StandardError; end
	end
end
