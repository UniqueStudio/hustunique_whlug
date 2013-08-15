#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/common/utils_module.rb"
	require "#{MAIN_PATH}include/config/dir_config.rb"
end

include Ash::Disposition

module Ash
	module ModuleApp

		class View
			attr_reader :api

			def initialize(obj_control)
				@api = obj_control
			end

			public
			def load_xhr_html(file_name, module_name = '')
				if Object.const_defined? :ASH_DEBUG
					file_path = "#{MAIN_PATH}plugin/#{module_name}/#{file_name}"
				else
					file_path = "#{UtilsModules.module_path}#{file_name}"
				end
				self.load_html(file_path)
			end

			alias_method :load_static_file, :load_xhr_html

			def load_setter_html
				if Object.const_defined? :ASH_DEBUG
					file_path = "#{MAIN_PATH}plugin/setter/setter.rhtml"
				else
					file_path = "#{Disposition::MAIN_DIR_PLUGIN}setter#{ASH_SEP}setter.rhtml"
				end
				self.load_html(file_path)
			end

			protected
			def load_html(path)
				raise ViewException, "#{path} do not exist or not readable" unless File.exist?(path) or File.readable?(path)
				File.open(path).read.to_s
			end
		end

		class ViewException < StandardError; end
	end
end
