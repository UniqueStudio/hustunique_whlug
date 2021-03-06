#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
	module Disposition

		SYS_PATH = "#{MAIN_PATH}system/" if Object.const_defined? :ASH_DEBUG

		SYS_DIR_BASE = "#{SYS_PATH}base#{File::SEPARATOR}"
		SYS_DIR_PACKAGE = "#{SYS_PATH}package#{File::SEPARATOR}"
		SYS_DIR_COMMON = "#{SYS_PATH}common#{File::SEPARATOR}"
		SYS_DIR_CORE = "#{SYS_PATH}core#{File::SEPARATOR}"

		MAIN_DIR_ADAPTER = "#{MAIN_PATH}adapter#{File::SEPARATOR}"

		MAIN_DIR_INCLUDE = "#{MAIN_PATH}include#{File::SEPARATOR}"
		MAIN_DIR_INCLUDE_CONFIG = "#{MAIN_DIR_INCLUDE}config#{File::SEPARATOR}"

		MAIN_DIR_ASSETS = "#{MAIN_PATH}assets#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_IMAGE = "#{MAIN_DIR_ASSETS}image#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_CSS = "#{MAIN_DIR_ASSETS}css#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_JS = "#{MAIN_DIR_ASSETS}js#{File::SEPARATOR}"

		MAIN_DIR_PLUGIN = "#{MAIN_PATH}plugin#{File::SEPARATOR}"

		MAIN_DIR_EXTRA= "#{MAIN_PATH}extra#{File::SEPARATOR}"
		MAIN_DIR_EXTRA_RSS= "#{MAIN_DIR_EXTRA}rss#{File::SEPARATOR}"
	end
end
