#encoding: UTF-8

exit unless defined? ACCESS_ERROR

require 'sinatra'
require 'pp'

begin

  require "#{MAIN_PATH}include#{File::SEPARATOR}ConfigCommon.rb"

  require "#{Ash::Disposition::SYS_DIR_COMMON}CommonUtils.rb"
	Ash::UtilsCommon.load_routing_conf_file

  require "#{Ash::Disposition::SYS_DIR_COMMON}CommonUtilsModules.rb"
  require "#{Ash::Disposition::SYS_DIR_COMMON}DbHelper.rb"

rescue LoadError => error
	puts error.to_s, error.backtrace.join('\n')
	puts "Local variable #{local_variables}"
end

#Ash::Disposition.constants.each do |cont|
	#pp "Ash::Disposition::#{cont} => " << Object.const_get("Ash::Disposition::#{cont}")
#end

#Module.constants.each {|value| puts "#{value} ==> #{Module.const_get value}"}
