#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/affair/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/affair/list/new')
	[status, headers, body]
end

get '/affair/list/new' do
	"hello"
end

get '/affair/list/:num' do
  Ash::UtilsModules.load_files 'affair'
	Ash::UtilsModules.display_outline(request.dup, 'view_list_info', params.dup)
	Ash::ModuleApp::AffairView.new.view_list_affair(params['num'])
end
