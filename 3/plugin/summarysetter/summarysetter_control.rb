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

		SummaryListPages = Struct.new(:content, :sum_info_length, :sum_pages_length, :each_page_langth, :now_page) do
			def get_binding; binding(); end
		end

		SummaryList = Struct.new(:title, :time, :location, :content, :nid) do
			def get_binding; binding(); end
		end

		class SummarysetterControl < Control

			public
			def ct_list_pages(page)
				et = ModuleTool::SummaryTool.new
				sum_info_length = et.summary_helper.active_count
				sum_pages_length = (sum_info_length / Disposition::COMMON_SUMMARY_PAGE_MAX_NUM.to_f).ceil
				page =1 if page <= 0 or sum_pages_length < page
				SummaryListPages.new(et.find_briefs(page), sum_info_length, sum_pages_length, Disposition::COMMON_SETTER_PAGE_MAX_NUM, page)
			end

			def ct_verify_add_summary(title, time, loc, cont)
				begin
					title, time, loc, cont = title.strip, time.strip, loc.strip, cont.strip

					_verify = self._ct_verify_summary(title, time, loc, cont)
					return _verify unless _verify.nil?
					ModuleTool::SummaryTool.new.insert(title, time, loc, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def ct_list_summarys(num)
				res = ModuleTool::SummaryTool.new.summary_helper.find_by_nid(num)
				return if res.nil?
				SummaryList.new(res.summary.title, res.summary.time, res.summary.location, res.summary.content, res.summary.nid)
			end

			def ct_verify_edit_summary(num, title, time, loc, cont)
				begin
					num, title, time, loc, cont = num.strip, title.strip, time.strip, loc.strip, cont.strip
					num = num.to_i
					et = ModuleTool::SummaryTool.new
					return UtilsBase.inte_err_info(4001, 'Page Do Not Edit') unless et.active?(num)

					_verify = self._ct_verify_summary(title, time, loc, cont)
					return _verify unless _verify.nil?
					et.update(num, title, time, loc, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			protected
			def _ct_verify_summary(title, time, loc, cont)
				return UtilsBase.inte_err_info(2001, 'Summary Title Not Empty') if title.empty?
				return UtilsBase.inte_err_info(2002, 'Summary Time Not Empty') if time.empty?
				return UtilsBase.inte_err_info(2003, 'Summary Time Format Error') unless UtilsBase.time?(time)
				return UtilsBase.inte_err_info(2004, 'Summary Location Not Empty') if loc.empty?
				return UtilsBase.inte_err_info(2005, 'Summary Content Not Empty') if cont.empty?
			end

		end
	end
end
