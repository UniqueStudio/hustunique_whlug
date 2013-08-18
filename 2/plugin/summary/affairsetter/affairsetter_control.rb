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

		AffairListPages = Struct.new(:content, :sum_info_length, :sum_pages_length, :each_page_langth, :now_page) do
			def get_binding; binding(); end
		end

		AffairList = Struct.new(:title, :time, :location, :content, :nid) do
			def get_binding; binding(); end
		end

		class AffairsetterControl < Control

			public
			def ct_list_pages(page)
				et = ModuleTool::AffairTool.new
				sum_info_length = et.affair_helper.active_count
				sum_pages_length = (sum_info_length / Disposition::COMMON_EVENT_PAGE_MAX_NUM.to_f).ceil
				page =1 if page <= 0 or sum_pages_length < page
				AffairListPages.new(et.find_briefs(page), sum_info_length, sum_pages_length, Disposition::COMMON_SETTER_PAGE_MAX_NUM, page)
			end

			def ct_verify_add_affair(title, time, loc, cont)
				begin
					title, time, loc, cont = title.strip, time.strip, loc.strip, cont.strip

					_verify = self._ct_verify_affair(title, time, loc, cont)
					return _verify unless _verify.nil?
					ModuleTool::AffairTool.new.insert(title, time, loc, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def ct_list_affairs(num)
				res = ModuleTool::AffairTool.new.affair_helper.find_by_nid(num)
				return if res.nil?
				AffairList.new(res.affair.title, res.affair.time, res.affair.location, res.affair.content, res.affair.nid)
			end

			def ct_verify_edit_affair(num, title, time, loc, cont)
				begin
					num, title, time, loc, cont = num.strip, title.strip, time.strip, loc.strip, cont.strip
					num = num.to_i
					et = ModuleTool::AffairTool.new
					return UtilsBase.inte_err_info(4001, 'Page Do Not Edit') unless et.active?(num)

					_verify = self._ct_verify_affair(title, time, loc, cont)
					return _verify unless _verify.nil?
					et.update(num, title, time, loc, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			protected
			def _ct_verify_affair(title, time, loc, cont)
				return UtilsBase.inte_err_info(2001, 'Affair Title Not Empty') if title.empty?
				return UtilsBase.inte_err_info(2002, 'Affair Time Not Empty') if time.empty?
				return UtilsBase.inte_err_info(2003, 'Affair Time Format Error') unless UtilsBase.time?(time)
				return UtilsBase.inte_err_info(2004, 'Affair Location Not Empty') if loc.empty?
				return UtilsBase.inte_err_info(2005, 'Affair Content Not Empty') if cont.empty?
			end

		end
	end
end
