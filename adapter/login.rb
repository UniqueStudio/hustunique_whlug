#coding: UTF-8

get '/wlg-login' do
	session.clear
	session[:ash_uid] = 0
  Ash::UtilsModules.load_module_files 'login'
	Ash::UtilsModules.display_module_outline(request.dup)
	Ash::ModuleApp::LoginView.new.default
end

post '/wlg-login' do
	session.clear
	session[:ash_uid] = 0
  Ash::UtilsModules.load_module_files 'login'
	Ash::UtilsModules.display_module_outline request.dup, 'view_verify_login', params
	Ash::ModuleApp::LoginView.new.view_verify_login(params['l_u_email'], params['l_u_pwd'], session)
end

#get '/login/randomImage' do
	#session.clear
	#session[:ash_uid] = 0
  #Ash::UtilsModules.load_module_files 'login'
	#Ash::UtilsModules.display_module_outline request.dup, 'view_random_image', params
	#Ash::ModuleApp::LoginView.new.view_random_image(params['l_r_email'])
#end

#get '/login/forgot_password' do
	#session.clear
	#session[:ash_uid] = 0
  #Ash::UtilsModules.load_module_files 'login'
	#Ash::UtilsModules.display_module_outline(request.dup, 'view_forgot_pwd')
	#Ash::ModuleApp::LoginView.new.view_forgot_pwd
#end

#post '/login/forgot_password' do
	#session.clear
	#session[:ash_uid] = 0
  #Ash::UtilsModules.load_module_files 'login'
	#Ash::UtilsModules.display_module_outline(request.dup, 'view_verify_forgot_pwd', params.dup)
	#Ash::ModuleApp::LoginView.new.view_verify_forgot_pwd(params['l_u_email'])
#end

#get '/login/reset_password/:uuid' do
	#session.clear
	#session[:ash_uid] = 0
  #Ash::UtilsModules.load_module_files 'login'
	#Ash::UtilsModules.display_module_outline(request.dup, 'view_reset_pwd', params.dup)
	#Ash::ModuleApp::LoginView.new.view_reset_pwd(params[:uuid])
#end

#post '/login/reset_password/:uuid' do
	#session.clear
	#session[:ash_uid] = 0
  #Ash::UtilsModules.load_module_files 'login'
	#Ash::UtilsModules.display_module_outline(request.dup, 'view_verify_reset_pwd', params.dup)
	#Ash::ModuleApp::LoginView.new.view_verify_reset_pwd(params[:uuid], params['l_r_u_pwd'])
#end
