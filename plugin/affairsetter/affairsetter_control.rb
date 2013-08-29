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

		class AffairsetterControl < Control

			public
			def ct_list_page(page = 1)
				et = ModuleTool::AffairTool.new
				sp_len = (et.affair_helper.active_count / Disposition::COMMON_AFFAIR_PAGE_MAX_NUM.to_f).ceil
				page = 1 if page <= 0 or sp_len < page
				l_page, r_page = page - 1, page + 1
				l_page = nil if l_page == 0
				r_page = nil if r_page > sp_len
				AffairListPages.new(et.find_briefs_by_page(page), page, l_page, r_page)
			end

			def ct_list_details(num = 1)
				ModuleTool::AffairTool.new.affair_helper.find_by_nid(num)
			end

			def ct_verify_add(title = '', writer = '', cont = '')
				begin
					title, writer, cont = title.strip, writer.strip, cont.strip

					_verify = self._ct_verify(title, writer, cont)
					return _verify unless _verify.nil?
					ModuleTool::AffairTool.new.insert(title, writer, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def ct_verify_edit(num = '', title = '', writer = '', cont = '')
				begin
					num, title, writer, cont = num.strip, title.strip, writer.strip, cont.strip

					num = num.to_i
					et = ModuleTool::AffairTool.new.init_affair(nid: num)
					return UtilsBase.inte_err_info(4001, 'Page Do Not Edit') unless et.active?

					_verify = self._ct_verify(title, writer, cont)
					return _verify unless _verify.nil?
					et.update(num, title, writer, cont)
					UtilsBase.inte_succ_info
				rescue
					UtilsBase.dev_mode? and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def ct_delete(num)
				cont = Disposition::COMMON_PAGE_DELETE_SUCC
				at = ModuleTool::AffairTool.new.init_affair(nid: num)
				if at.active?
					cont = Disposition::COMMON_PAGE_DELETE_ERROR unless at.affair_helper.not_active
				else
					cont = Disposition::COMMON_PAGE_NOT_EXIST
				end
				cont
			end

			protected
			def _ct_verify(title, writer, cont)
				return UtilsBase.inte_err_info(2001, 'Affair Title Not Empty') if title.empty?
				return UtilsBase.inte_err_info(2002, 'Affair Time Not Empty') if writer.empty?
				return UtilsBase.inte_err_info(2005, 'Affair Content Not Empty') if cont.empty?
			end

		end
	end
end
