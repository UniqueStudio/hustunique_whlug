#coding: UTF-8

get '/wlg-login' do
	session.clear
	#session[:ash_uid] = 0
  Ash::UtilsModules.load_files 'login'
	Ash::UtilsModules.display_outline(request.dup)
	Ash::ModuleApp::LoginView.new.default
end

post '/wlg-login' do
	session.clear
	#session[:ash_uid] = 0
  Ash::UtilsModules.load_files 'login'
	Ash::UtilsModules.display_outline request.dup, 'view_verify_login', params
	Ash::ModuleApp::LoginView.new.view_verify_login(params['l_u_email'], params['l_u_pwd'], session)
end

get '/wlg/logout' do
	session.clear
	session[:ash_uid] = 0
	redirect to('/wlg-login')
end
