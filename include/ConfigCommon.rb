#coding: UTF-8

module Ash
	module Disposition

		SYS_DIR_LIB = "#{SYS_PATH}lib#{File::SEPARATOR}"
		SYS_DIR_COMMON = "#{SYS_PATH}common#{File::SEPARATOR}"

		MAIN_DIR_ADAPTER = "#{MAIN_PATH}adapter#{File::SEPARATOR}"

		MAIN_DIR_INCLUDE = "#{MAIN_PATH}include#{File::SEPARATOR}"

		MAIN_DIR_ASSETS = "#{MAIN_PATH}assets#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_IMAGE = "#{MAIN_DIR_ASSETS}image#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_CSS = "#{MAIN_DIR_ASSETS}css#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_JS = "#{MAIN_DIR_ASSETS}js#{File::SEPARATOR}"
		MAIN_DIR_ASSETS_FONTS = "#{MAIN_DIR_ASSETS}fonts#{File::SEPARATOR}"

		MAIN_DIR_PLUGIN = "#{MAIN_PATH}plugin#{File::SEPARATOR}"
		
		MONGODB_HOSTNAME = ENV['ASH_MONGODB_HOSTNAME'] || 'localhost'
		MONGODB_PORT = ENV['ASH_MONGODB_PORT'] || Mongo::MongoClient::DEFAULT_PORT
		MONGODB_DBNAME = 'ash_wuhan_linux_group'
		MONGODB_TABLE_PREFIX = 'wlgdev_'

		# 2 (minus)(600(s))
		COMMON_TOKEN_EXPIRES = 60 * 2

		# active user
		COMMON_PARTY_ACTIVE = '128'

	end
end
