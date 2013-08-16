require 'rss/maker'

content = RSS::Maker.make('2.0') do |m|
 m.channel.title = "title"
 #m.channel.about = "about" # <<<=seems to not be used
 m.channel.link  = "www.example.com"
 m.channel.description = "desc"
 m.items.do_sort = true # <<<= sort items by date

 2.times do |n|
	 i = m.items.new_item
	 i.title = "title"
	 i.link =  "www.example.com/" + n.to_s
	 # i.guid =    <<<=Not supported
	 i.description = "Main body"
	 i.date = Time.now
 end
end

File.open('x.xml', 'w'){|file| file.write(content.to_s)}
 #puts content.to_s
