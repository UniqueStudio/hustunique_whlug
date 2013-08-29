require 'rufus-scheduler'
require 'pp'

scheduler = Rufus::Scheduler.new

scheduler.every('2013/') do
	pp Time.now
end
scheduler.join
