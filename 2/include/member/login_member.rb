#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require 'digest'

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}include/member/member.rb"
	require "#{MAIN_PATH}include/config/common_config.rb"
else
	require "#{Ash::Disposition::MAIN_DIR_INCLUDE}member#{ASH_SEP}member.rb"
end

module Ash
	module ExtraDB

		class LoginMHelper

			attr_reader :member
			def initialize
				@member_helper = MemberHelper.new
				@member, @db_helper = @member_helper.member, @member_helper.helper
			end

			public
			def verify_member
				result = @member_helper.find_all_by_email
				result.member if !result.nil? and result.member.password == Digest::MD5.hexdigest(@member.password)
			end

			def init_member(args)
				args.map {|key, value| @member.instance_variable_set("@#{key}", value)}
				self
			end

		end
	end
end
