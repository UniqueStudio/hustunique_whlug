#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/wlg/setting/summary' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/summary/page/1')
	[status, headers, body]
end
get '/wlg/setting/summary/page' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/summary/page/1')
	[status, headers, body]
end
get '/wlg/setting/summary/page/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'summarysetter'
	Ash::UtilsModules.display_outline(request.dup, 'default', params.dup)
	Ash::ModuleApp::SummarysetterView.new.default(params['num'])
end

get '/wlg/setting/summary/add' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'summarysetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_add_summary')
	Ash::ModuleApp::SummarysetterView.new.view_add_summary
end

post '/wlg/setting/summary/add' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'summarysetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_add_summary', params.dup)
	Ash::ModuleApp::SummarysetterView.new.view_verify_add_summary(params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end

get '/wlg/setting/summary/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/summary/list/1')
	[status, headers, body]
end
get '/wlg/setting/summary/list/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'summarysetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_info', params.dup)
	Ash::ModuleApp::SummarysetterView.new.view_list_summary(params['num'])
end

get '/wlg/setting/summary/edit/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'summarysetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_edit_summary', params.dup)
	Ash::ModuleApp::SummarysetterView.new.view_edit_summary(params['num'])
end

post '/wlg/setting/summary/edit/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'summarysetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_edit_summary', params.dup)
	Ash::ModuleApp::SummarysetterView.new.view_verify_edit_summary(params['num'], params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end
