#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-
require 'rubygems'
require 'open-uri'
require 'kconv'
require 'hpricot'
require 'pp'

src = URI("http://www.nttdocomo.co.jp/service/imode/make/content/spec/screen_area/index.html").read.toutf8
src.gsub!(/&mu;/,"myu")
user_agents = {}

(Hpricot(src)/"//div[@id='maincol']//table").each do |table|
  (table/"tr[@class='acenter']").each do |tr|
    a = (tr/:td).map {|x| x.inner_text }
    i = 0
    if a.size == 7
      if a[0] =~ /[A-Z]{1,2}\-\d{2}A/ # iモードブラウザ2.0
        i = 1
      else
        a.shift # remove rowspan
      end
    elsif a.size != 6
      raise "something is wrong"
    end
    a[0].sub!(/（.*）/,"")
    a[0].sub!(/\(.+\)/,"")
    a[0].sub!(/-/,'') # F-01A -> F01A
    a[0].sub!(/$/,'3') if i == 1 # iモードブラウザ2.0

    a[3+i].sub!(/^.*?(\d+×\d+).*$/,'\1')
    width, height = a[3+i].split(/×/,2).map{|x| x.to_i}
    case a[5+i]
    when /^カラー\s*(\d+)色$/
      color_p = true
      colors = $1.to_i
    when /^白黒(\d+)階調$/
      color_p = false
      colors = $1.to_i
    else
      raise "something is wrong (in detecting colors)"
    end
    user_agents[a[0]] = {:browser_width=>width, :browser_height=>height, :color_p=>color_p, :colors=>colors}
  end
end

# 書き出し
open("lib/jpmobile/mobile/z_display_info_docomo.rb","w") do |f|
  f.puts "Jpmobile::Mobile::Docomo::DISPLAY_INFO ="
  f.puts user_agents.pretty_inspect
end
