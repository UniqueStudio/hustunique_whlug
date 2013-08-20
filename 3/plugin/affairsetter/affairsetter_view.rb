#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}plugin/affairsetter/affairsetter_control.rb"
	require "#{MAIN_PATH}include/common/page.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}affairsetter#{ASH_SEP}affairsetter_control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}page.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class AffairsetterView < View

			def initialize; super(AffairsetterControl.new); end

			def view_list_page(num = nil)
				begin
					return UtilsBase.inte_bigerr_info if num.nil?
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					cont = ERB.new(self.load_static_file('page.rhtml', 'affairsetter')).result(@api.ct_list_page(num).get_binding)
					ERB.new(self.load_admin_file).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
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
					cont = ERB.new(self.load_static_file('details.rhtml', 'affairsetter')).result(_e.get_binding)
					ERB.new(self.load_admin_file).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_add
				ERB.new(self.load_admin_file).result(ModuleTool::PagesetterList.new(self.load_static_file('add.html', 'affairsetter'), Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
			end

			def view_verify_add(*args); @api.ct_verify_add(*args); end

			def view_edit(num = nil)
				begin
					return UtilsBase.inte_bigerr_info if num.nil?
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					_e = @api.ct_list_details(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					cont = ERB.new(self.load_static_file('edit.rhtml', 'affairsetter')).result(_e.get_binding)
					ERB.new(self.load_admin_file).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_delete(num = nil)
				begin
					return UtilsBase.inte_bigerr_info if num.nil?
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					del_content = @api.ct_delete(num)
					cont = ERB.new(self.load_static_file('delete.rhtml', 'affairsetter')).result(binding)
					ERB.new(self.load_admin_file).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_AFFAIR).get_binding)
				rescue
				end
			end

			def view_verify_edit_affair(*args); @api.ct_verify_edit_affair(*args); end

		end
	end
end
