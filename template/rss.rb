require 'rss/maker'
require 'pp'

#MAIN_PATH = File.expand_path(File.dirname(File.dirname(__FILE__)))
ACCESS_ERROR  = 
ASH_SEP = File::SEPARATOR
MAIN_PATH = File.dirname(File.expand_path(File.dirname(__FILE__))) << ASH_SEP

WEB_URI = 'www.wlug.org'

require "#{MAIN_PATH}include/config/common_config.rb"
require "#{MAIN_PATH}include/affair/affair_tool.rb"
require "#{MAIN_PATH}include/event/event_tool.rb"
require "#{MAIN_PATH}include/summary/summary_tool.rb"


pp Ash::ModuleTool::AffairTool.new.find_all_by_page(1)
#content = RSS::Maker.make('2.0') do |m|
	#m.channel.title = "Wuhan Linux User Group"
	##m.channel.about = "about" # <<<=seems to not be used
	#m.channel.link  = WEB_URI
	#m.channel.description = "这是一个Linux爱好者的社区平台"
	#m.items.do_sort = true # <<<= sort items by date

	#affair = Ash::AffairTool.new.find_all_by_page(1)
	#if !affair.empty?
		#affair.map do |list|
			#i = m.items.new_item
			#i.title = list.title
			#i.link = "#{WEB_URI}/affair/list/#{list.nid}"
			#i.description = list.content
			#i.date = list.fmt_time
			#i.editor = list.writer
		#end
	#end
#end
 ##2.times do |n|
	 ##i = m.items.new_item
	 ##i.title = "title"
	 ##i.link =  "www.example.com/" + n.to_s
	 ### i.guid =    <<<=Not supported
	 ##i.description = "Main body"
	 ##i.date = Time.now
 ##end
##end
#pp content.to_s
#File.open("#{MAIN_PATH}template/rss/feed.xml", 'w+'){|file| file.write(content.to_s)}
#pp File.open("#{MAIN_PATH}template/rss/feed.xml").read.to_s
