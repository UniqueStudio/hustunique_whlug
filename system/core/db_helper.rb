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
			@@collections = ["AuthMembers"]

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

			def find_all(*need_key)
				self.find({}, *need_key)
			end

			def find(query = {}, *need_key)
				final, result = [], @collection.find(query).to_a
				unless need_key.empty?
					result.each do |item|
						temp_final = {}
						need_key.each {|value| temp_final[value] = item[value] if item.has_key?(value)}
						final << temp_final.merge({'_id' => item['_id']}).sort
					end
				end
				final.empty? ? result : final
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
