#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}plugin/summary/summary_control.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}summary#{ASH_SEP}summary_control.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class SummaryView < View

			def initialize; super(SummaryControl.new); end

			#def default(num)
				#begin
					#num = num.to_i
					#return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					#cont = ERB.new(self.load_static_file('list_summaries.rhtml', 'summary')).result(@api.ct_list_pages(num).get_binding())
					#ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_SUMMARY).get_binding)
				#rescue
					#UtilsBase.dev_mode? and raise
					#UtilsBase.inte_bigerr_info
				#end
			#end

			def view_list_summary(num)
				begin
					num = num.to_i
					return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
					_e = @api.ct_list_summarys(num)
					return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
					cont = ERB.new(self.load_static_file('list_detailed_summary.rhtml', 'summary')).result(_e.get_binding)
					ERB.new(self.load_setter_html).result(ModuleTool::PagesetterList.new(cont, Disposition::COMMON_PAGE_EDIT_SUMMARY).get_binding)
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

		end
	end
end
