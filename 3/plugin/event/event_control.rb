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

    EventListPages = Struct.new(:content, :now_page, :left_page, :right_page) do
      def get_binding; binding(); end
    end

    #EventList = Struct.new(:title, :fmt_time, :content, :nid, :writer, ) do
    #def get_binding; binding(); end
    #end

    class EventControl < Control

      public
      def ct_list_page(page = 1)
        et = ModuleTool::EventTool.new
        sp_len = (et.event_helper.active_count / Disposition::COMMON_EVENT_PAGE_MAX_NUM.to_f).ceil
        page = 1 if page <= 0 or sp_len < page
        l_page, r_page = page - 1, page + 1
        l_page = nil if l_page == 0
        r_page = nil if r_page > sp_len
        EventListPages.new(et.find_det_briefs_by_page(page), page, l_page, r_page)
      end

      def ct_list_details(num = 1)
        at = ModuleTool::EventTool.new.init_event(nid: num)
        res = at.event_helper.find_by_nid(num)
        return if res.nil?
        at.event_helper.hits_increase
        res.hits = res.hits + 1
        res
      end

    end
  end
end
