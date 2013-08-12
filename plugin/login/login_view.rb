#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/view.rb"
	require "#{MAIN_PATH}login/login_control.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
	require "#{Ash::Disposition::MAIN_DIR_PLUGIN}login#{ASH_SEP}login_control.rb"
end

module Ash
	module ModuleApp

		class LoginView < View

			def initialize
				super(LoginControl.new)
			end

			def default; self.load_static_file('login.html'); end

			def view_verify_login(*args); @api.ct_verify_login(*args); end

		end
	end
end
