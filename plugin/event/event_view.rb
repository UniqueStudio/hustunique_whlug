#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

if Object.const_defined? :ASH_DEBUG
  require "#{MAIN_PATH}plugin/event/event_control.rb"
  require "#{MAIN_PATH}include/common/page.rb"
else
  require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
  require "#{Ash::Disposition::MAIN_DIR_PLUGIN}event#{ASH_SEP}event_control.rb"
  require "#{Ash::Disposition::MAIN_DIR_INCLUDE}common#{ASH_SEP}page.rb"
end

require 'erb'

module Ash
  module ModuleApp

    class EventView < View

      def initialize; super(EventControl.new); end

      def view_list_page(num = nil)
        begin
          return UtilsBase.inte_bigerr_info if num.nil?
          num = num.to_i
          return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
          ERB.new(self.load_static_file('page.rhtml', 'event')).result(@api.ct_list_page(num).get_binding)
        rescue
          UtilsBase.dev_mode? and raise
          UtilsBase.inte_bigerr_info
        end
      end

      def view_list_details(num = nil)
        begin
          return UtilsBase.inte_bigerr_info if num.nil?
          num = num.to_i
          return UtilsBase.inte_bigerr_info unless num.instance_of? Fixnum
          _e = @api.ct_list_details(num)
          return UtilsBase.inte_err_info(3001, "Page Not Exist") if _e.nil?
          ERB.new(self.load_static_file('details.rhtml', 'event')).result(_e.get_binding)
        rescue
          UtilsBase.dev_mode? and raise
          UtilsBase.inte_bigerr_info
        end
      end

    end
  end
end
