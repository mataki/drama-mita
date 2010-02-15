# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require "faker"
require 'machinist/active_record'
require 'sham'

Sham.define do
  title { |index| Faker::Lorem.words.join(' ') }
  drama_title { |index| %w(24-シーズン1 24-シーズン2 プリズンブレイク-シーズン1 プリズンブレイク-シーズン2).rand + index.to_s }
  episode_title { |index| %w(mat危機一髪 脱獄の日 奇跡 1時 2時).rand + index.to_s }
  name { |index| %w(Mat Akihiro Maedana interu kuranuki).rand + index.to_s }
  content { |index| %w(とってもおもしろかった いまいちだった もう一度みたい この話はいまいちだった 出演者のあのひとが嫌い).rand + index.to_s }
  num { |index| index }
end

User.blueprint do
  name
end

Category.blueprint do
  title
end

Drama.blueprint do
  title { Sham.drama_title }
  category
end

Episode.blueprint do
  drama
  num
  title { Sham.episode_title }
end

Watch.blueprint do
  user
  episode
  content
end

user = User.make
friends = (1..3).map{ |i| User.make }

local = Category.make(:title => "アクション")
global = Category.make(:title => "ヒューマン")

local_dramas = (1..2).map{ |i| Drama.make(:category => local) }
global_dramas = (1..2).map{ |i|  Drama.make(:category => local) }

[local_dramas, global_dramas].flatten.each do |drama|
  (1..5).map{ |i| Episode.make(:drama => drama) }
  Sham.reset
end

episode = local_dramas.rand.episodes.rand
Watch.make(:episode => episode, :user => user)

episode = local_dramas.rand.episodes.rand
Watch.make(:episode => episode, :user => friends.first)
