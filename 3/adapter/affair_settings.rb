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
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_page', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_list_page(params['num'])
end

get '/wlg/setting/affair/add' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_add')
	Ash::ModuleApp::AffairsetterView.new.view_add
end

post '/wlg/setting/affair/add' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_add', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_verify_add(params['e_s_title'], params['e_s_writer'], params['e_s_cont'])
end

get '/wlg/setting/affair/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/list/1')
	[status, headers, body]
end
get '/wlg/setting/affair/list/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_details', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_list_details(params['num'])
end

get '/wlg/setting/affair/edit/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_edit', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_edit(params['num'])
end

post '/wlg/setting/affair/edit/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_edit', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_verify_edit(params['num'], params['e_s_title'], params['e_s_time'], params['e_s_loc'], params['e_s_cont'])
end

get '/wlg/setting/affair/delete/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'affairsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_delete', params.dup)
	Ash::ModuleApp::AffairsetterView.new.view_delete(params['num'])
end
