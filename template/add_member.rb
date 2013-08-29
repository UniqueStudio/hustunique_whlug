#!/usr/bin/env ruby
#coding: UTF-8

require 'pp'
require 'mongo'

mongo_coll = Mongo::MongoClient.new('localhost', 27017).db('ash_ruby_project_wuhan_linux_group').collection('arpwlgDev1_AuthMembers')
pp mongo_coll.find_one
