#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/config/db_config.rb"
end

include Ash::Disposition

module Ash

	module DB

		class DBHelper

			attr_reader :collection
			@@collections = ["AuthMembers", "Homepage", "Events", "Affairs", "Summaries"]

			def initialize(collection_name, db_name = MONGODB_DBNAME)
				raise ArguemntError, "DBHelper initialize argument error" if self.in_collections? collection_name
				collection_name = self.format_colleation_name collection_name

				db_conn = Mongo::MongoClient.new MONGODB_HOSTNAME, MONGODB_PORT
				@collection = db_conn.db(db_name).collection(collection_name)
			end

			public
			def find_one(query = {}, *need_key)
				fields = {}
				unless need_key.empty?
					need_key.each { |value| fields[value] = 1}
				end
				fields.empty? ? @collection.find_one(query) : @collection.find_one(query, :fields => fields)
			end

			def find_all
				self.find({})
			end

			def find(query = {})
				final = @collection.find(query).to_a
				final.empty? ? nil : final
			end

			def find_by(query = {})
				@collection.find(query)
			end

			def count
				@collection.count
			end

			def insert(insert_value); @collection.insert(insert_value); end

			def remove(query); @collection.remove(query); end

			def update(*query); @collection.update(*query); end

			protected
			def format_colleation_name(collection_name)
				"#{MONGODB_TABLE_PREFIX}#{collection_name}"
			end

			def in_collections?(collection_name)
				nil == @@collections.index(collection_name)
			end
		end
	end
end
