#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require 'mongo'

module Ash

	module Disposition

		MONGODB_HOSTNAME = ENV['ASH_MONGODB_HOSTNAME'] || 'localhost'
		MONGODB_PORT = ENV['ASH_MONGODB_PORT'] || Mongo::MongoClient::DEFAULT_PORT
		MONGODB_DBNAME = 'ash_ruby_project_wuhan_linux_group'
		MONGODB_TABLE_PREFIX = 'arpwlgDev1_'

	end
end
