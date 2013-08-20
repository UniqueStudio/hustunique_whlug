#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/activity' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/new')
	[status, headers, body]
end
get '/activity/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/new')
	[status, headers, body]
end
get '/activity/list/' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/new')
	[status, headers, body]
end
get '/activity/new' do
  Ash::UtilsModules.load_files 'event'
	Ash::UtilsModules.display_outline(request.dup, 'view_new_event')
	Ash::ModuleApp::EventView.new.view_new_event
end

get '/activity/list/:num' do
  Ash::UtilsModules.load_files 'event'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_event', params.dup)
	Ash::ModuleApp::EventView.new.view_list_event(params['num'])
end
