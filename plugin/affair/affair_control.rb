#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/affair/affair_tool.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}affair#{ASH_SEP}affair_tool.rb"
end

module Ash
	module ModuleApp

		AffairListPages = Struct.new(:content, :now_page, :left_page, :right_page) do
			def get_binding; binding(); end
		end

		#AffairList = Struct.new(:title, :fmt_time, :content, :nid, :writer, ) do
			#def get_binding; binding(); end
		#end

		class AffairControl < Control

			public
			def ct_list_page(page = 1)
				et = ModuleTool::AffairTool.new
				sp_len = (et.affair_helper.active_count / Disposition::COMMON_AFFAIR_PAGE_MAX_NUM.to_f).ceil
				page = 1 if page <= 0 or sp_len < page
				l_page, r_page = page - 1, page + 1
				l_page = nil if l_page == 0
				r_page = nil if r_page > sp_len
				AffairListPages.new(et.find_det_briefs_by_page(page), page, l_page, r_page)
			end

			def ct_list_details(num = 1)
				at = ModuleTool::AffairTool.new.init_affair(nid: num)
				res = at.affair_helper.find_by_nid(num)
				return if res.nil?
				at.affair_helper.hits_increase
				res.hits = res.hits + 1
				res
			end

		end
	end
end
