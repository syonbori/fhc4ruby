#!/bin/env ruby
# -*- coding: utf-8 -*-
require 'fhc4ruby'
require 'pp'

API_KEY  = ""
FHC_HOST = "fhc.example.com"
FHC_PORT = 80

fhc = FHC.new(API_KEY, FHC_HOST, FHC_PORT)

puts "*** 家電一覧の取得"
ret = fhc.get_list
list = ret.list
puts "* 家電一覧"
pp list

puts "*** 家電情報の取得"
list.each do |name|
  puts name
  act_list = fhc.get_action_list(name)
  pp act_list
  info = fhc.get_info(name)
  pp info
  puts
end

puts "*** 家電操作"
ret = fhc.action("扇風機", "つける")
pp ret # result: ok
ret = fhc.action("扇風機", "けす")
pp ret # result: ok
ret = fhc.action("扇風機", "うんこ")
pp ret # result: >>> ok <<< (always returns "ok")

puts "*** センサ取得"
ret = fhc.get_sensor_raw()
# pp ret
puts "temp: #{fhc.temp}"
puts "lumi: #{fhc.lumi}"

