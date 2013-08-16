#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/config/common_config.rb"
	require "#{MAIN_PATH}system/core/db_helper.rb"
	require "#{MAIN_PATH}system/common/utils_base.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}db_helper.rb"
	require "#{Ash::Disposition::SYS_DIR_COMMON}utils_base.rb"
end

module Ash
	module ExtraDB

		class Event

			attr_accessor :id, :title, :time, :timestamp, :content, :location, :nid, :active
			def initialize(args = {})
				raise EventException, "Event initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end
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
						time: event['time'] || nil,
						timestamp: event['timestamp'] || nil,
						content: event['content'] || nil,
						location: event['location'] || nil,
						nid: event['nid'] || nil,
						active: event.has_key?('isActive') ? self.active?(event['isActive']) : nil
					)
				end
				@event = @event.first  if @event.length == 1
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

			def find_all_by_email(email = nil)
				@event.email = email unless email.nil?
				raise EventException, "email error" if @event.email.nil? or !UtilsBase.email?(@event.email)
				result = @helper.find_one({email: @event.email})
				return result if result.nil?
				EventResult.new(result)
			end

			def find_all_by_uid(uid = nil)
				@event.id = uid unless uid.nil?
				raise EventException, "uid error" if @event.id.nil? or !BSON::ObjectId.legal?(@event.id)
				result = @helper.find_one({_id: BSON::ObjectId(@event.id)})
				return result if result.nil?
				EventResult.new(result)
			end

			def find_by_nid(nid = nil)
				@event.nid = nid unless nid.nil?
				raise EventException, "nid error" unless @event.nid.instance_of? Fixnum
				result = @helper.find_one({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s, nid: @event.nid})
				return result if result.nil?
				EventResult.new(result)
			end

			def init_event(arg = {})
				arg.map {|key, value| @event.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

			def find_last_nid
				res = @helper.find_by({}).sort({_id: -1}).limit(1).to_a
				res.empty? ? 0 : res.first['nid']
			end

			def format_page(page)
				raise HomepageException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_EVENT_PAGE_MAX_NUM
			end

			def active_count
				@helper.find_by({isActive: Disposition::COMMON_EVENT_IS_ACTIVE.to_s}).to_a.length
			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				EventResult.new(result.sort(timestamp: -1).limit(nlimit).skip(nskip).to_a)
			end
		end

		class EventException < StandardError; end
	end
end
