#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require "#{Ash::Disposition::SYS_DIR_LIB}LibView#{FILE_EXT}"
require "#{Ash::Disposition::MAIN_DIR_PLUGIN}home#{File::SEPARATOR}HomeControl#{FILE_EXT}"

module Ash
	module ModuleApp

		class CViewHome < Ash::ModuleApp::CView
			
			def initialize
				super(Ash::ModuleApp::CControlHome.new)
			end

			def default
				load_static_file('home.html')
			end
		end
	end
end
