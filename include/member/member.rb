#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/config/common_config.rb"
	require "#{MAIN_PATH}system/core/db_helper.rb"
	require "#{MAIN_PATH}system/common/utils_base.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}db_helper.rb"
	require "#{Ash::Disposition::SYS_DIR_COMMON}utils_base.rb"
end

module Ash
	module ExtraDB

		class Member

			attr_accessor :id, :email, :name, :uuid, :password, :registered_time, :active
			def initialize(args = {})
				raise MemberException, "Member initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end
		end

		class MemberResult

			attr_reader :member
			def initialize(members)
				@member = []
				members = [members] unless members.is_a? Array
				members.map do |member|
					raise MemberException, "MemberResult initialize argument error" unless member.is_a? Hash
					@member << Member.new(
						id: member['_id'].to_s || nil,
						email: member['email'] || nil,
						name: member['name'] || nil,
						uuid: member['uuid'] || nil,
						password: member['passwordMD5'] || nil,
						registered_time: member['registeredTime'] || nil,
						active: member.has_key?('isActive') ? self.active?(member['isActive']) : nil
					)
				end
				@member = @member.first  if @member.length == 1
			end

			protected
			def active?(act); act == Disposition::COMMON_IS_ACTIVE.to_s; end
		end

		class MemberHelper
			attr_accessor :member
			attr_reader :helper

			def initialize
				@member_db_name = 'AuthMembers'
				@helper = DB::DBHelper.new(@member_db_name)
				@member = Member.new
			end

			def member?(mid = nil)
				@member.id = mid unless mid.nil?
				raise MemberException, "uid error" if @member.id.nil? or !BSON::ObjectId.legal?(@member.id)
				!@helper.find_one({_id: BSON::ObjectId(@member.id)}).nil?
			end

			def find_all_by_email(email = nil)
				@member.email = email unless email.nil?
				raise MemberException, "email error" if @member.email.nil? or !UtilsBase.email?(@member.email)
				result = @helper.find_one({email: @member.email})
				return result if result.nil?
				MemberResult.new(result)
			end

			def find_all_by_uid(uid = nil)
				@member.id = uid unless uid.nil?
				raise MemberException, "uid error" if @member.id.nil? or !BSON::ObjectId.legal?(@member.id)
				result = @helper.find_one({_id: BSON::ObjectId(@member.id)})
				return result if result.nil?
				MemberResult.new(result)
			end
		end

		class MemberException < StandardError; end
	end
end
