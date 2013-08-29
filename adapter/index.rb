#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/' do
  Ash::UtilsModules.load_files 'index'
	Ash::UtilsModules.display_outline(request.dup)
	Ash::ModuleApp::IndexView.new.default
end

get '/introduction' do
  Ash::UtilsModules.load_files 'introduction'
	Ash::UtilsModules.display_outline(request.dup)
	Ash::ModuleApp::IntroductionView.new.default
end

get '/contact' do
  Ash::UtilsModules.load_files 'contact'
	Ash::UtilsModules.display_outline(request.dup)
	Ash::ModuleApp::ContactView.new.default
end
