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

		class Homepage

			attr_accessor :id, :email, :name, :time, :active, :content
			def initialize(args = {})
				raise HomepageException, "Member initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end
		end

		class HomepageResult

			attr_reader :page
			def initialize(pages)
				@page = []
				pages = [pages] unless pages.is_a? Array
				pages.map do |page|
					raise HomepageException, "MemberResult initialize argument error" unless page.is_a? Hash
					@page << Homepage.new(
						id: page['_id'].to_s || nil,
						email: page['changeUserEmail'] || nil,
						name: page['changeUserName'] || nil,
						time: page['time'] || nil,
						active: page.has_key?('isBeingUsed') ? self.active?(page['isBeingUsed']) : nil,
						content: page['content'] || nil,
					)
				end
				@page = @page.first  if @page.length == 1
			end

			protected
			def active?(act); act == Disposition::COMMON_SETTER_IS_BEING_USED.to_s; end
		end

		class HomepageHelper
			attr_accessor :page
			attr_reader :helper

			def initialize
				@page_db_name = 'Homepage'
				@helper = DB::DBHelper.new(@page_db_name)
				@page = Homepage.new
			end

			def find_all(nlimit = 10, nskip = 0)
				self._find_all({}, nlimit, nskip)
			end

			def find_all_by_email(email = nil, nlimit = 10, nskip = 0)
				@page.email = email unless email.nil?
				raise HomepageException, "email error" if @page.email.nil? or !UtilsBase.email?(@page.email)
				self._find_all({changeUserEmail: @page.email}, nlimit, nskip)
			end

			def find_all_by_id(id = nil, nlimit = 10, nskip = 0)
				@page.id = id unless id.nil?
				raise HomepageException, "uid error" if @page.id.nil? or !BSON::ObjectId.legal?(@page.id)
				self._find_all({_id: BSON::ObjectId(@page.id)}, nlimit, nskip)
			end

			def init_page(arg = {})
				arg.map {|key, value| @page.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

			def find_used
				@page.active = Disposition::COMMON_SETTER_IS_BEING_USED.to_s
				result = @helper.find_one({isBeingUsed: @page.active})
				return nil if result.nil?
				HomepageResult.new(result)
			end

			def format_page(page)
				raise HomepageException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_SETTER_PAGE_MAX_NUM

			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				HomepageResult.new(result.sort(time: -1).limit(nlimit).skip(nskip).to_a)
			end

		end

		class HomepageException < StandardError; end
	end
end
