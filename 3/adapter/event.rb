#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/activity' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/page/1')
	[status, headers, body]
end
get '/activity/' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/page/1')
	[status, headers, body]
end
get '/activity/page' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/page/1')
	[status, headers, body]
end
get '/activity/page/' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/page/1')
	[status, headers, body]
end
get '/activity/page/:num' do
  Ash::UtilsModules.load_files 'event'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_page', params.dup)
	Ash::ModuleApp::EventView.new.view_list_page(params['num'])
end

#get '/wlg/setting/event/list' do
	#status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/list/1')
	#[status, headers, body]
#end
get '/activity/list/:num' do
  Ash::UtilsModules.load_files 'event'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_details', params.dup)
	Ash::ModuleApp::EventView.new.view_list_details(params['num'])
end
