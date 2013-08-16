#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/wlg/setting/homepage' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'homesetter'
	Ash::UtilsModules.display_module_outline(request.dup)
	Ash::ModuleApp::HomesetterView.new.default(session.dup, request.xhr?)
end

get '/wlg/setting/homepage/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/homepage/list/1')
	[status, headers, body]
end

get '/wlg/setting/homepage/list/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'homesetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'view_list_info', params.dup)
	Ash::ModuleApp::HomesetterView.new.view_list_info(params[:num])
end

post '/wlg/session/homepage/edit' do
end
