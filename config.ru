#coding: UTF-8

require 'sinatra'

set :env, :production
disable :run

$: << File.expand_path(File.dirname(__FILE__))
require './index.rb'

run Sinatra::Application
