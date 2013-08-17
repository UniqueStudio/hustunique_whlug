#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
	require "#{MAIN_PATH}system/core/db_helper.rb"
else
	require "#{Ash::Disposition::SYS_DIR_CORE}db_helper.rb"
	require "#{Ash::Disposition::SYS_DIR_COMMON}utils_base.rb"
end

module Ash
	module ExtraDB

		class Affair

			attr_accessor :id, :title, :time, :timestamp, :content, :location, :nid, :active
			def initialize(args = {})
				raise AffairException, "Affair initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end
		end

		class AffairResult

			attr_reader :affair
			def initialize(affairs)
				@affair = []
				affairs = [affairs] unless affairs.is_a? Array
				affairs.map do |affair|
					raise AffairException, "AffairResult initialize argument error" unless affair.is_a? Hash
					@affair << Affair.new(
						id: affair['_id'].to_s || nil,
						title: affair['title'] || nil,
						time: affair['time'] || nil,
						timestamp: affair['timestamp'] || nil,
						content: affair['content'] || nil,
						location: affair['location'] || nil,
						nid: affair['nid'] || nil,
						active: affair.has_key?('isActive') ? self.active?(affair['isActive']) : nil
					)
				end
				@affair = @affair.first  if @affair.length == 1
			end

			protected
			def active?(act); act == Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s; end
		end

		class AffairHelper
			attr_accessor :affair
			attr_reader :helper

			def initialize
				@affair_db_name = 'Affairs'
				@helper = DB::DBHelper.new(@affair_db_name)
				@affair = Affair.new
			end

			def find_all_by_email(email = nil)
				@affair.email = email unless email.nil?
				raise AffairException, "email error" if @affair.email.nil? or !UtilsBase.email?(@affair.email)
				result = @helper.find_one({email: @affair.email})
				return result if result.nil?
				AffairResult.new(result)
			end

			def find_all_by_uid(uid = nil)
				@affair.id = uid unless uid.nil?
				raise AffairException, "uid error" if @affair.id.nil? or !BSON::ObjectId.legal?(@affair.id)
				result = @helper.find_one({_id: BSON::ObjectId(@affair.id)})
				return result if result.nil?
				AffairResult.new(result)
			end

			def find_by_nid(nid = nil)
				@affair.nid = nid unless nid.nil?
				raise AffairException, "nid error" unless @affair.nid.instance_of? Fixnum
				result = @helper.find_one({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s, nid: @affair.nid})
				return result if result.nil?
				AffairResult.new(result)
			end

			def init_affair(arg = {})
				arg.map {|key, value| @affair.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

			def find_last_nid
				res = @helper.find_by({}).sort({_id: -1}).limit(1).to_a
				res.empty? ? 0 : res.first['nid']
			end

			def format_page(page)
				raise HomepageException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_AFFAIR_PAGE_MAX_NUM
			end

			def active_count
				@helper.find_by({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s}).to_a.length
			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				AffairResult.new(result.sort(timestamp: -1).limit(nlimit).skip(nskip).to_a)
			end
		end

		class AffairException < StandardError; end
	end
end
