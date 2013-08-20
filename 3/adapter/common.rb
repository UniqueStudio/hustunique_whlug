#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require 'sinatra'
require 'digest'

set :public_folder, "#{MAIN_PATH}assets"

set :session_secret, ENV["SESSION_KEY"] || Digest::MD5.hexdigest(ENV['ASH_MONGODB_PASSWORD'])
enable :sessions

before do
	session[:ash_uid] ||= 0
end

helpers do
	def checked?
		return false if !Ash::ExtraDB::MemberHelper.new.member?(session[:ash_uid])
		return false if session[:ash_ustartt].nil?
		_t = Time.now.to_i - session[:ash_ustartt].to_i
		return false if _t < 0 or _t > Ash::Disposition::COMMON_ADMIN_MAX_TIME
		true
	end
end

#helpers do
	#def checked?(check = false)
		#return false if session[:ash_uid] == 0
		#return false unless Ash::ExtraDB::MemberHelper.new.member?(session[:ash_uid])
		#if check === true
			#return false if session[:ash_ttid].nil? or session[:ash_tuuid].nil?
			#return false unless Ash::ExtraDB::TeamHelper.new.team?(session[:ash_ttid], session[:ash_tuuid])
		#elsif ASH_MODE == ASH_MODE_DEV
			#if !session[:ash_ttid].nil? and !session[:ash_tuuid].nil?
				#return false unless Ash::ExtraDB::TeamHelper.new.team?(session[:ash_ttid], session[:ash_tuuid])
			#end
		#end
		#true
	#end

#end
