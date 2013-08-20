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

			attr_accessor :id, :title, :fmt_time, :content, :nid, :active, :writer, :hits, :origin
			def initialize(args = {})
				raise AffairException, "Affair initialize argument error" unless args.instance_of? Hash
				args.map { |key, value| instance_variable_set("@#{key}", value)} unless args.empty?
			end

			def get_binding; binding(); end
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
						fmt_time: affair.has_key?('time') ? UtilsBase.format_time(affair['time']) : nil,
						content: affair['content'] || nil,
						nid: affair.has_key?('nid') ? affair['nid'].to_i : nil,
						active: affair.has_key?('isActive') ? UtilsBase.active?(affair['isActive'], Disposition::COMMON_AFFAIR_IS_ACTIVE) : nil,
						writer: affair['writer'] || nil,
						hits: affair.has_key?('hits') ? affair['hits'].to_i : nil,
						origin: affair['origin'] || nil,
					)
				end
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

			def find_by_nid(nid = nil)
				@affair.nid = nid unless nid.nil?
				raise AffairException, "nid error" unless @affair.nid.instance_of? Fixnum
				result = @helper.find_one({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s, nid: @affair.nid})
				return if result.nil?
				AffairResult.new(result).affair.first
			end

			def find_last_nid
				res = @helper.find_by({}).sort({_id: -1}).limit(1).to_a
				res.empty? ? 0 : res.first['nid']
			end

			def num_affairs(page)
				raise AffairException, "format_page argument error" unless page.instance_of? Fixnum
				page = 1 if page <= 1
				(page - 1) * Disposition::COMMON_AFFAIR_PAGE_MAX_NUM
			end

			def active_count
				@helper.find_by({isActive: Disposition::COMMON_AFFAIR_IS_ACTIVE.to_s}).to_a.length
			end

			def hits_increase(nid = nil)
				@affair.nid = nid unless nid.nil?
				raise AffairException, "hits_increase argument error" unless @affair.nid.instance_of? Fixnum
				@helper.update({nid: @affair.nid}, {"$inc" => {hits: 1}})['updatedExisting']
			end

			def not_active(nid = nil)
				@affair.nid = nid unless nid.nil?
				raise AffairException, "not_active argument error" unless @affair.nid.instance_of? Fixnum
				@helper.update({nid: @affair.nid}, {"$set" => {isActive: Disposition::COMMON_AFFAIR_NOT_IS_ACTIVE.to_s}})['updatedExisting']
			end

			protected
			def _find_all(query = {}, nlimit = 10, nskip = 0)
				result = @helper.find_by(query)
				return nil if result.nil?
				AffairResult.new(result.sort(time: -1).limit(nlimit).skip(nskip).to_a)
			end
		end

		class AffairException < StandardError; end
	end
end
