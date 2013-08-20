#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/summary' do
	status, headers, body = call env.merge("PATH_INFO" => '/summary/page/1')
	[status, headers, body]
end
get '/summary/' do
	status, headers, body = call env.merge("PATH_INFO" => '/summary/page/1')
	[status, headers, body]
end
get '/summary/page' do
	status, headers, body = call env.merge("PATH_INFO" => '/summary/page/1')
	[status, headers, body]
end
get '/summary/page/' do
	status, headers, body = call env.merge("PATH_INFO" => '/summary/page/1')
	[status, headers, body]
end
get '/summary/page/:num' do
  Ash::UtilsModules.load_files 'summary'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_page', params.dup)
	Ash::ModuleApp::SummaryView.new.view_list_page(params['num'])
end

#get '/wlg/setting/summary/list' do
	#status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/summary/list/1')
	#[status, headers, body]
#end
get '/summary/list/:num' do
  Ash::UtilsModules.load_files 'summary'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_details', params.dup)
	Ash::ModuleApp::SummaryView.new.view_list_details(params['num'])
end
