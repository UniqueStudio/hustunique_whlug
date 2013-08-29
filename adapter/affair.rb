#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/affair' do
	status, headers, body = call env.merge("PATH_INFO" => '/affair/page/1')
	[status, headers, body]
end
get '/affair/' do
	status, headers, body = call env.merge("PATH_INFO" => '/affair/page/1')
	[status, headers, body]
end
get '/affair/page' do
	status, headers, body = call env.merge("PATH_INFO" => '/affair/page/1')
	[status, headers, body]
end
get '/affair/page/' do
	status, headers, body = call env.merge("PATH_INFO" => '/affair/page/1')
	[status, headers, body]
end
get '/affair/page/:num' do
  Ash::UtilsModules.load_files 'affair'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_page', params.dup)
	Ash::ModuleApp::AffairView.new.view_list_page(params['num'])
end

#get '/wlg/setting/affair/list' do
	#status, headers, body = call env.merge("PATH_INFO" => '/wlg/setting/affair/list/1')
	#[status, headers, body]
#end
get '/affair/list/:num' do
  Ash::UtilsModules.load_files 'affair'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_details', params.dup)
	Ash::ModuleApp::AffairView.new.view_list_details(params['num'])
end
