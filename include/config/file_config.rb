#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
	module Disposition

		MAIN_FILE_HTML_HEAD = "#{MAIN_DIR_ASSETS_HTML}head.html"
		MAIN_FILE_HTML_BOTTOM = "#{MAIN_DIR_ASSETS_HTML}bottom.html"
		MAIN_FILE_RSS = "#{MAIN_DIR_EXTRA_RSS}rss_dev.xml"
		MAIN_FILE_RSS_BAK = "#{MAIN_DIR_EXTRA_RSS}rss_dev.bak.xml"

	end
end
