#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/wlg/setting' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/page/1')
	[status, headers, body]
end
get '/wlg/setting/' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/page/1')
	[status, headers, body]
end

get '/wlg/setting/affair' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/page/1')
	[status, headers, body]
end
get '/wlg/setting/affair/page' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/page/1')
	[status, headers, body]
end
get '/wlg/setting/affair/page/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'default', params.dup)
	Ash::ModuleApp::AffairsetterView.new.default(params['num'])
end

get '/wlg/setting/affair/add' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_add_affair')
	Ash::ModuleApp::AffairsetterView.new.view_add_affair
end

post '/wlg/setting/affair/add' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_add_affair', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_verify_add_affair(params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end

get '/wlg/setting/affair/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/list/1')
	[status, headers, body]
end
get '/wlg/setting/affair/list/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_info', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_list_affair(params['num'])
end

get '/wlg/setting/affair/edit/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_edit_affair', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_edit_affair(params['num'])
end

post '/wlg/setting/affair/edit/:num' do
	redirect to('/wlg-login') if session[:ash_uid] == 0
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_edit_affair', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_verify_edit_affair(params['num'], params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end
