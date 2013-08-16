#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/wlg/setting' do

	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]

end

get '/wlg/setting/' do

	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]

end

get '/wlg/setting/event' do

	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]

end

get '/wlg/setting/event/page' do

	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]

end
get '/wlg/setting/event/page/' do

	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]

end

get '/wlg/setting/event/page/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'eventsetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'default', params.dup)
	Ash::ModuleApp::EventsetterView.new.default(request.xhr?, params['num'])
end

get '/wlg/setting/event/add' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'eventsetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'view_add_event')
	Ash::ModuleApp::EventsetterView.new.view_add_event
end

post '/wlg/setting/event/add' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'eventsetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'view_verify_add_event', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_verify_add_event(params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end

get '/wlg/setting/event/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/list/1')
	[status, headers, body]
end

get '/wlg/setting/event/list/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'eventsetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'view_list_info', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_list_event(params['num'])
end

get '/wlg/setting/event/edit/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'eventsetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'view_edit_event', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_edit_event(params['num'])
end

post '/wlg/setting/event/edit/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_module_files 'eventsetter'
	Ash::UtilsModules.display_module_outline(request.dup, 'view_verify_edit_event', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_verify_edit_event(params['num'], params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end
