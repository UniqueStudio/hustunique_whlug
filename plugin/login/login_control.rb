#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/control.rb"
	require "#{MAIN_PATH}include/member/login_member.rb"
	require "#{MAIN_PATH}include/config/dir_config.rb"
	require "#{MAIN_PATH}system/common/utils_common.rb"
	require "#{MAIN_PATH}system/common/utils_base.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}control.rb"
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}member#{ASH_SEP}login_member.rb"
end

module Ash
	module ModuleApp

		class LoginControl < Control

			def ct_verify_login(email, pwd, session)
				begin
					email, pwd = email.strip, pwd.strip

					!UtilsBase.email?(email) and return UtilsBase.inte_err_info(1002, "Email Input Error")
					!UtilsBase.password?(pwd) and return UtilsBase.inte_err_info(1003, "Password Input Error")
					(user_info = self.check_set_user(email, pwd, session)) === true or return user_info
					UtilsBase.inte_succ_info
				rescue
					ASH_MODE == ASH_MODE_DEV and raise
					UtilsBase.inte_bigerr_info
				end
			end

			def check_set_user(email, pwd, session)
				lm = ExtraDB::LoginMHelper.new.init_member(email: email, password: pwd).verify_member
				lm.nil? and return UtilsBase.inte_err_info(1004, 'Account Error')
				session[:ash_uid], session[:ash_uname], session[:ash_uemail], session[:ash_ustartt] = lm.id, lm.name, lm.email, Time.now.to_i.to_s
				true
			end

		end
	end
end
