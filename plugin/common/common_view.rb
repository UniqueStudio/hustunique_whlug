#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"
require "#{Ash::Disposition::MAIN_DIR_PLUGIN}common#{ASH_SEP}common_control.rb"

module Ash
	module ModuleApp

		class CommonView < View

			def initialize; super(CommonControl.new); end

      def image_uploader(*args)
        @api.ct_image_uploader(*args)
      end

      def image_browser;
        file_arr = Set.new(Dir.glob("#{Disposition::MAIN_DIR_ASSETS}pictures/*.*"))
        #pp file_arr
        #self.load_static_file()
      end;

      def rss_subscribe
        @api.ct_rss_subscribe
      end

		end
	end
end
