#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}plugin/index/index_control.rb"
	require "#{MAIN_PATH}include/common/page.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}index#{ASH_SEP}index_control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}page.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class IndexView < View

			def initialize; super(IndexControl.new); end

			def default
				begin
					ERB.new(self.load_static_file('index.rhtml', 'index')).result(@api.ct_list_all_pages.get_binding)
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end


		end
	end
end
