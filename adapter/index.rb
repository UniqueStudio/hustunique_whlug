#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/' do
  Ash::UtilsModules.load_files 'index'
	Ash::UtilsModules.display_outline(request.dup)
	Ash::ModuleApp::IndexView.new.default
end
