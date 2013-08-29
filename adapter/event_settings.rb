#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/wlg/setting/event' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]
end
get '/wlg/setting/event/page' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	[status, headers, body]
end
get '/wlg/setting/event/page/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_page', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_list_page(params['num'])
end

get '/wlg/setting/event/add' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_add')
	Ash::ModuleApp::EventsetterView.new.view_add
end

post '/wlg/setting/event/add' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_add', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_verify_add(params['e_s_title'], params['e_s_writer'], params['e_s_cont'])
end

get '/wlg/setting/event/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/list/1')
	[status, headers, body]
end
get '/wlg/setting/event/list/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_details', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_list_details(params['num'])
end

get '/wlg/setting/event/edit/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_edit', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_edit(params['num'])
end

post '/wlg/setting/event/edit/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_verify_edit', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_verify_edit(params['num'], params['e_s_title'], params['e_s_writer'], params['e_s_cont'])
end

get '/wlg/setting/event/delete/:num' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'eventsetter'
	Ash::UtilsModules.display_outline(request.dup, 'view_delete', params.dup)
	Ash::ModuleApp::EventsetterView.new.view_delete(params['num'])
end
