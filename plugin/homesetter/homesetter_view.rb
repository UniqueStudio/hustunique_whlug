#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/view.rb"
	require "#{MAIN_PATH}plugin/homesetter/homesetter_control.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}homesetter#{ASH_SEP}homesetter_control.rb"
end

require 'erb'

module Ash
	module ModuleApp

		class HomesetterView < View

			def initialize
				super(HomesetterControl.new)
			end

			def default(session, xhr)
				begin
					content = xhr ? self.load_static_file('homesetter.rhtml', 'homesetter') : self.load_setter_html
					ERB.new(content).result(@api.ct_default(xhr).binding)
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def view_list_info(page)
				begin
					!page.instance_of? Fixnum and return UtilsBase.inte_bigerr_info
					ERB.new(self.load_static_file('list_info.rhtml', 'homesetter')).result(@api.ct_list_info(page).binding)
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end

		end
	end
end
