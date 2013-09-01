#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
require "#{Ash::Disposition::MAIN_DIR_PLUGIN}common#{ASH_SEP}common_control.rb"

require 'erb'

module Ash
	module ModuleApp

		class CommonView < View

			def initialize; super(CommonControl.new); end

      def image_uploader(*args)
        @api.ct_image_uploader(*args)
      end

      def image_browser
        file_arr = []
        Dir.foreach("#{Disposition::MAIN_DIR_ASSETS}pictures/"){|f| next if f == '.' or f == '..'; file_arr << f}
        file_arr.sort!{|x, y| y <=> x}
        ERB.new(self.load_static_file('image_browser.rhtml')).result(binding())
      end;

      def rss_subscribe
        @api.ct_rss_subscribe
      end

		end
	end
end
