#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}plugin/affair/affair_control.rb"
	require "#{MAIN_PATH}include/common/page.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}affair#{ASH_SEP}affair_control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}page.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class AffairView < View

			def initialize; super(AffairControl.new); end

			def view_list_page(num = nil)
				begin
					return UtilsBase.inte_bigerr_info if num.nil?
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					cont = ERB.new(self.load_static_file('page.rhtml', 'affair')).result(@api.ct_list_page(num).get_binding)
					ERB.new(self.load_client_file).result(ModuleTool::PageList.new(cont, Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_list_details(num = nil)
				begin
					return UtilsBase.inte_bigerr_info if num.nil?
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					_e = @api.ct_list_details(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					cont = ERB.new(self.load_static_file('details.rhtml', 'affair')).result(_e.get_binding)
					ERB.new(self.load_client_file).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

		end
	end
end
