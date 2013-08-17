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

		class Summary

			attr_accessor :id, :title, :time, :timestamp, :content, :location, :nid, :active
			def initialize(args = {})
				raise SummaryException, "Summary initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end
		end

		class SummaryResult

			attr_reader :summary
			def initialize(summarys)
				@summary = []
				summarys = [summarys] unless summarys.is_a? Array
				summarys.map do |summary|
					raise SummaryException, "SummaryResult initialize argument error" unless summary.is_a? Hash
					@summary << Summary.new(
						id: summary['_id'].to_s || nil,
						title: summary['title'] || nil,
						time: summary['time'] || nil,
						timestamp: summary['timestamp'] || nil,
						content: summary['content'] || nil,
						location: summary['location'] || nil,
						nid: summary['nid'] || nil,
						active: summary.has_key?('isActive') ? self.active?(summary['isActive']) : nil
					)
				end
				@summary = @summary.first  if @summary.length == 1
			end

			protected
			def active?(act); act == Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s; end
		end

		class SummaryHelper
			attr_accessor :summary
			attr_reader :helper

			def initialize
				@summary_db_name = 'Summaries'
				@helper = DB::DBHelper.new(@summary_db_name)
				@summary = Summary.new
			end

			def find_all_by_email(email = nil)
				@summary.email = email unless email.nil?
				raise SummaryException, "email error" if @summary.email.nil? or !UtilsBase.email?(@summary.email)
				result = @helper.find_one({email: @summary.email})
				return result if result.nil?
				SummaryResult.new(result)
			end

			def find_all_by_uid(uid = nil)
				@summary.id = uid unless uid.nil?
				raise SummaryException, "uid error" if @summary.id.nil? or !BSON::ObjectId.legal?(@summary.id)
				result = @helper.find_one({_id: BSON::ObjectId(@summary.id)})
				return result if result.nil?
				SummaryResult.new(result)
			end

			def find_by_nid(nid = nil)
				@summary.nid = nid unless nid.nil?
				raise SummaryException, "nid error" unless @summary.nid.instance_of? Fixnum
				result = @helper.find_one({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s, nid: @summary.nid})
				return result if result.nil?
				SummaryResult.new(result)
			end

			def init_summary(arg = {})
				arg.map {|key, value| @summary.instance_variable_set("@#{key}", value)} unless arg.empty?
				self
			end

			def find_last_nid
				res = @helper.find_by({}).sort({_id: -1}).limit(1).to_a
				res.empty? ? 0 : res.first['nid']
			end

			def format_page(page)
				raise SummaryException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_SUMMARY_PAGE_MAX_NUM
			end

			def active_count
				@helper.find_by({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s}).to_a.length
			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				SummaryResult.new(result.sort(timestamp: -1).limit(nlimit).skip(nskip).to_a)
			end
		end

		class SummaryException < StandardError; end
	end
end
