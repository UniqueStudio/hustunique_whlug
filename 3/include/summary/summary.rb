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

			attr_accessor :id, :title, :fmt_time, :content, :nid, :active, :writer, :hits, :origin
			def initialize(args = {})
				raise SummaryException, "Summary initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end

			def get_binding; binding(); end
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
						fmt_time: summary.has_key?('time') ? UtilsBase.format_time(summary['time']) : nil,
						content: summary['content'] || nil,
						nid: summary.has_key?('nid') ? summary['nid'].to_i : nil,
						active: summary.has_key?('isActive') ? UtilsBase.active?(summary['isActive'], Disposition::COMMON_SUMMARY_IS_ACTIVE) : nil,
						writer: summary['writer'] || nil,
						hits: summary.has_key?('hits') ? summary['hits'].to_i : nil,
						origin: summary['origin'] || nil,
					)
				end
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

			def find_by_nid(nid = nil)
				@summary.nid = nid unless nid.nil?
				raise SummaryException, "nid error" unless @summary.nid.instance_of? Fixnum
				result = @helper.find_one({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s, nid: @summary.nid})
				return if result.nil?
				SummaryResult.new(result).summary.first
			end

			def find_last_nid
				res = @helper.find_by({}).sort({_id: -1}).limit(1).to_a
				res.empty? ? 0 : res.first['nid']
			end

			def num_summarys(page)
				raise SummaryException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_SUMMARY_PAGE_MAX_NUM
			end

			def active_count
				@helper.find_by({isActive: Disposition::COMMON_SUMMARY_IS_ACTIVE.to_s}).to_a.length
			end

			def hits_increase(nid = nil)
				@summary.nid = nid unless nid.nil?
				raise SummaryException, "hits_increase argument error" unless @summary.nid.instance_of? Fixnum
				@helper.update({nid: @summary.nid}, {"$inc" => {hits: 1}})['updatedExisting']
			end

			def not_active(nid = nil)
				@summary.nid = nid unless nid.nil?
				raise SummaryException, "not_active argument error" unless @summary.nid.instance_of? Fixnum
				@helper.update({nid: @summary.nid}, {"$set" => {isActive: Disposition::COMMON_SUMMARY_NOT_IS_ACTIVE.to_s}})['updatedExisting']
			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				SummaryResult.new(result.sort(time: -1).limit(nlimit).skip(nskip).to_a)
			end
		end

		class SummaryException < StandardError; end
	end
end
