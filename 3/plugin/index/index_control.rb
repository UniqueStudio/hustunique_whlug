#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/affair/affair_tool.rb"
	require "#{MAIN_PATH}include/event/event_tool.rb"
	require "#{MAIN_PATH}include/summary/summary_tool.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}affair#{ASH_SEP}affair_tool.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}event#{ASH_SEP}event_tool.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}summary#{ASH_SEP}summary_tool.rb"
end

module Ash
	module ModuleApp

		IndexListPages = Struct.new(:affair, :event, :summary, :length) do
			def get_binding; binding(); end
		end

		#IndexList = Struct.new(:title, :fmt_time, :content, :nid, :writer, ) do
			#def get_binding; binding(); end
		#end

		class IndexControl < Control

			public
			def ct_list_all_pages
				IndexListPages.new(ModuleTool::AffairTool.new.find_briefs_by_page(1), ModuleTool::EventTool.new.find_briefs_by_page(1), ModuleTool::SummaryTool.new.find_briefs_by_page(1), Disposition::COMMON_PAGE_LIST_INDEX_MAX_LENGTH)
			end

		end
	end
end
