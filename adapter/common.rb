#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

post '/wlg/setting/image_uploader' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'common'
	Ash::UtilsModules.display_outline(request.dup, 'image_uploader', params.dup)
	Ash::ModuleApp::CommonView.new.image_uploader(params)
end

get '/wlg/setting/image_browser' do
	redirect to('/wlg-login') unless checked?
  Ash::UtilsModules.load_files 'common'
	Ash::UtilsModules.display_outline(request.dup, 'image_browser', params.dup)
	Ash::ModuleApp::CommonView.new.image_browser
end

get '/feed' do
  Ash::UtilsModules.load_files 'common'
	Ash::UtilsModules.display_outline(request.dup, 'rss_subscribe', params.dup)
	Ash::ModuleApp::CommonView.new.rss_subscribe
end
