#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/activity' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/list/1')
	[status, headers, body]
end
#get '/wlg/setting/event/page' do
	#status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/event/page/1')
	#[status, headers, body]
#end
#get '/wlg/setting/event/page/:num' do
	#redirect to('/wlg-login') if session[:ash_uid] == 0
  #Ash::UtilsModules.load_files 'eventsetter'
	#Ash::UtilsModules.display_outline(request.dup, 'default', params.dup)
	#Ash::ModuleApp::EventsetterView.new.default(params['num'])
#end

get '/activity/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/activity/list/1')
	[status, headers, body]
end
get '/activity/list/:num' do
  Ash::UtilsModules.load_files 'event'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_info', params.dup)
	Ash::ModuleApp::EventView.new.view_list_event(params['num'])
end
