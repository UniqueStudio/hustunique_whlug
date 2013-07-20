#coding: UTF-8

require 'sinatra'
require 'pp'

get '/' do
	#redirect to('/login') if session[:ash_uid] == 0
	#Ash::Utils.set_module_gvar 'home'
  Ash::UtilsModules.load_module_files 'home'
	Ash::UtilsModules.display_module_outline request.path_info
	Ash::ModuleApp::CViewHome.new.default
end
