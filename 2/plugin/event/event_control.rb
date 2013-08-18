#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/event/event_tool.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}event#{ASH_SEP}event_tool.rb"
end

module Ash
	module ModuleApp

		EventListPages = Struct.new(:content, :sum_info_length, :sum_pages_length, :each_page_langth, :now_page) do
			def get_binding; binding(); end
		end

		EventList = Struct.new(:title, :time, :location, :content, :nid, :left, :right) do
			def get_binding; binding(); end
		end

		class EventControl < Control

			public
			def ct_list_pages(page)
				et = ModuleTool::EventTool.new
				sum_info_length = et.event_helper.active_count
				sum_pages_length = (sum_info_length / Disposition::COMMON_EVENT_PAGE_MAX_NUM.to_f).ceil
				page =1 if page <= 0 or sum_pages_length < page
				EventListPages.new(et.find_briefs(page), sum_info_length, sum_pages_length, Disposition::COMMON_SETTER_PAGE_MAX_NUM, page)
			end

			def ct_list_events(num)
				mt = ModuleTool::EventTool.new
				res = mt.event_helper.find_by_nid(num)
				os = mt.find_du_briefs(num)
				return if res.nil?
				EventList.new(res.event.title, res.event.time, res.event.location, res.event.content, res.event.nid, os.first, os.last)
			end

		end
	end
end
