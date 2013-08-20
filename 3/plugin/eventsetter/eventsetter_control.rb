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

		EventList = Struct.new(:title, :time, :location, :content, :nid) do
			def get_binding; binding(); end
		end

		class EventsetterControl < Control

			public
			def ct_list_page(page)
				et = ModuleTool::EventTool.new
				sp_len = (et.event_helper.active_count / Disposition::COMMON_EVENT_PAGE_MAX_NUM.to_f).ceil
				page =1 if page <= 0 or sp_len < page
				if sp_len != 1
					l_page, r_page = (page == 1 ? nil : page - 1), (page == sp_len ? page - 1 : nil)
				else
					l_page = r_page = nil
				end
				EventListPages.new(et.find_briefs_by_page(page), page, l_page, r_page)
			end

			def ct_verify_add_event(title, time, loc, cont)
				begin
					title, time, loc, cont = title.strip, time.strip, loc.strip, cont.strip

					_verify = self._ct_verify_event(title, time, loc, cont)
					return _verify unless _verify.nil?
					ModuleTool::EventTool.new.insert(title, time, loc, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def ct_list_events(num)
				res = ModuleTool::EventTool.new.event_helper.find_by_nid(num)
				return if res.nil?
				EventList.new(res.event.title, res.event.time, res.event.location, res.event.content, res.event.nid)
			end

			def ct_verify_edit_event(num, title, time, loc, cont)
				begin
					num, title, time, loc, cont = num.strip, title.strip, time.strip, loc.strip, cont.strip
					num = num.to_i
					et = ModuleTool::EventTool.new
					return UtilsBase.inte_err_info(4001, 'Page Do Not Edit') unless et.active?(num)

					_verify = self._ct_verify_event(title, time, loc, cont)
					return _verify unless _verify.nil?
					et.update(num, title, time, loc, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			protected
			def _ct_verify_event(title, time, loc, cont)
				return UtilsBase.inte_err_info(2001, 'Event Title Not Empty') if title.empty?
				return UtilsBase.inte_err_info(2002, 'Event Time Not Empty') if time.empty?
				return UtilsBase.inte_err_info(2003, 'Event Time Format Error') unless UtilsBase.time?(time)
				return UtilsBase.inte_err_info(2004, 'Event Location Not Empty') if loc.empty?
				return UtilsBase.inte_err_info(2005, 'Event Content Not Empty') if cont.empty?
			end

		end
	end
end
