#coding: UTF-8

require 'pp'
require 'sinatra'

ACCESS_ERROR = true unless Object.const_defined? :ACCESS_ERROR

ASH_MODE_CLIENT = 7
ASH_MODE_DEV = 77

# develpement mode
ASH_MODE = ASH_MODE_DEV

# File::SEPARATOR
ASH_SEP = File::SEPARATOR

MAIN_PATH = File.expand_path(File.dirname(__FILE__)) << ASH_SEP
Dir.chdir MAIN_PATH

SYS_PATH = MAIN_PATH + 'system' + ASH_SEP
raise "#{SYS_PATH} not exist" unless File.directory? SYS_PATH

require "#{MAIN_PATH}include#{ASH_SEP}config#{ASH_SEP}dir_config.rb"
require "#{Ash::Disposition::MAIN_DIR_INCLUDE_CONFIG}common_config.rb"
require "#{Ash::Disposition::MAIN_DIR_INCLUDE_CONFIG}db_config.rb"
#require "#{Ash::Disposition::SYS_DIR_COMMON}utils_common.rb"
require "#{Ash::Disposition::SYS_DIR_COMMON}utils_module.rb"
require "#{Ash::Disposition::SYS_DIR_COMMON}utils_base.rb"
Ash::UtilsCommon.load_routing_conf_files
