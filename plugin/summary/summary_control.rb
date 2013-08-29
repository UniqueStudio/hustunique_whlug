#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/summary/summary_tool.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}summary#{ASH_SEP}summary_tool.rb"
end

module Ash
	module ModuleApp

		SummaryListPages = Struct.new(:content, :now_page, :left_page, :right_page) do
			def get_binding; binding(); end
		end

		#SummaryList = Struct.new(:title, :fmt_time, :content, :nid, :writer, ) do
			#def get_binding; binding(); end
		#end

		class SummaryControl < Control

			public
			def ct_list_page(page = 1)
				et = ModuleTool::SummaryTool.new
				sp_len = (et.summary_helper.active_count / Disposition::COMMON_SUMMARY_PAGE_MAX_NUM.to_f).ceil
				page = 1 if page <= 0 or sp_len < page
				l_page, r_page = page - 1, page + 1
				l_page = nil if l_page == 0
				r_page = nil if r_page > sp_len
				SummaryListPages.new(et.find_det_briefs_by_page(page), page, l_page, r_page)
			end

			def ct_list_details(num = 1)
				at = ModuleTool::SummaryTool.new.init_summary(nid: num)
				res = at.summary_helper.find_by_nid(num)
				return if res.nil?
				at.summary_helper.hits_increase
				res.hits = res.hits + 1
				res
			end

		end
	end
end
