#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}plugin/event/event_control.rb"
	#require "#{MAIN_PATH}include/common/page.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}event#{ASH_SEP}event_control.rb"
	#require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}page.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class EventView < View

			def initialize; super(EventControl.new); end

			#def default(num)
				#begin
					#num = num.to_i
					#return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					#cont = ERB.new(self.load_static_file('list_events.rhtml', 'event')).result(@api.ct_list_pages(num).get_binding())
					#ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
				#rescue
					#UtilsBase.dev_mode? and raise
					#UtilsBase.inte_bigerr_info
				#end
			#end

			def view_list_event(num)
				begin
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					_e = @api.ct_list_events(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					ERB.new(self.load_static_file('event.rhtml', 'event')).result(_e.get_binding)
					#ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_edit_event(num)
				begin
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					_e = @api.ct_list_events(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					cont = ERB.new(self.load_static_file('edit_event.rhtml', 'event')).result(_e.get_binding)
					ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_EVENT).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_verify_edit_event(*args); @api.ct_verify_edit_event(*args); end

		end
	end
end
