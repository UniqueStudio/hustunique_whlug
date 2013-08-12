#encoding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require "#{MAIN_PATH}include#{ASH_SEP}config#{ASH_SEP}dir_config.rb"

include Ash::Disposition

require "#{MAIN_DIR_INCLUDE_CONFIG}file_config.rb"
require "#{MAIN_DIR_INCLUDE_CONFIG}common_config.rb"
require "#{MAIN_DIR_INCLUDE_CONFIG}db_config.rb"

require "#{SYS_DIR_COMMON}utils_common.rb"
Ash::UtilsCommon.load_routing_conf_files

require "#{SYS_DIR_COMMON}utils_module.rb"
require "#{SYS_DIR_COMMON}utils_base.rb"

require "#{MAIN_DIR_INCLUDE_CLASS}member#{ASH_SEP}member.rb"
require "#{MAIN_DIR_INCLUDE_CLASS}team#{ASH_SEP}team.rb"

#Ash::Disposition.constants.each do |cont|
	#pp "Ash::Disposition::#{cont} => " << Object.const_get("Ash::Disposition::#{cont}")
#end

#Module.constants.each {|value| puts "#{value} ==> #{Module.const_get value}"}
