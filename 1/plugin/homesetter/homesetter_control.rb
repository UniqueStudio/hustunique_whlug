#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/control.rb"
	require "#{MAIN_PATH}include/config/dir_config.rb"
	require "#{MAIN_PATH}system/common/utils_common.rb"
	require "#{MAIN_PATH}system/common/utils_base.rb"
	require "#{MAIN_PATH}include/common/pagesetter.rb"
	require "#{MAIN_PATH}include/homepage/homepage.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}pagesetter.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}homepage#{ASH_SEP}homepage.rb"
end

module Ash
	module ModuleApp

		class HomesetterControl < Control

			public
			def ct_default(xhr, session)
				being_use = ExtraDB::HomepageHelper.new.find_used
				return ModuleTool::PagesetterList.new(nil, ModuleTool::PagesetterMsgList.new(being_use, '')) if xhr
				ModuleTool::PagesetterList.new(ModuleTool::PagesetterUserList.new(session[:ash_uname], session[:ash_uemail]), ModuleTool::PagesetterMsgList.new(being_use, ''))
			end

			def ct_list_info(page)
				hp = ExtraDB::HomepageHelper.new
				sum_info_length = hp.helper.count
				sum_pages_length = (sum_info_length / Disposition::COMMON_SETTER_PAGE_MAX_NUM).to_i + 1

				page =1 if sum_pages_length < page
				content = hp.find_all(Disposition::COMMON_SETTER_PAGE_MAX_NUM, hp.format_page(page))
				Struct.new(:content, :sum_info_length, :sum_pages_length, :each_page_langth).new(content, sum_info_length, sum_pages_length, Disposition::COMMON_SETTER_PAGE_MAX_NUM)
			end

		end
	end
end
