#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

get '/test' do
	status, headers, body = call env.merge("PATH_INFO" => '/test/new')
	[status, headers, body]
end
get '/test/list' do
	status, headers, body = call env.merge("PATH_INFO" => '/test/new')
	[status, headers, body]
end
get '/test/list/' do
	status, headers, body = call env.merge("PATH_INFO" => '/test/new')
	[status, headers, body]
end
get '/test/new' do
	"new"
end

get '/test/list/:num' do
	"list" + params['num']
end
