#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/view.rb"
	require "#{MAIN_PATH}plugin/eventsetter/eventsetter_control.rb"
	require "#{MAIN_PATH}include/common/pagesetter.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}eventsetter#{ASH_SEP}eventsetter_control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}pagesetter.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class EventsetterView < View

			def initialize
				super(EventsetterControl.new)
			end

			def default(xhr, num)
				begin
					num = num.to_i
					!num.instance_of? Fixnum and return UtilsBase.inte_bigerr_info
					list = self.load_static_file('list_event_setter.rhtml', 'eventsetter')
					page = @api.ct_list_pages(num)
					#return UtilsBase.inte_bigerr_info if page.nil?
					list_cont = ERB.new(list).result(binding())
					return list_cont if xhr
					ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(list_cont, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_add_event
				add = self.load_static_file('add_event_setter.html', 'eventsetter')
				ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(add, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
			end

			def view_verify_add_event(*args)
				@api.ct_verify_add_event(*args)
			end

			def view_list_event(num)
				begin
					num = num.to_i
					!num.instance_of? Fixnum and return UtilsBase.inte_bigerr_info
					_e = @api.ct_list_events(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					event = _e.event
					cont = ERB.new(self.load_static_file('list_detailed_event.rhtml', 'eventsetter')).result(binding)
					ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_edit_event(num)
				begin
					num = num.to_i
					!num.instance_of? Fixnum and return UtilsBase.inte_bigerr_info
					_e = @api.ct_list_events(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					event = _e.event
					cont = ERB.new(self.load_static_file('edit_event.rhtml', 'eventsetter')).result(binding)
					ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_verify_edit_event(*args)
				@api.ct_verify_edit_event(*args)
			end

		end
	end
end
