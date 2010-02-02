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
  title { Faker::Lorem.words.join(' ') }
  name { Faker::Name.name }
  content { Faker::Lorem.sentence }
  num { |index| index }
end

User.blueprint do
  name
end

Category.blueprint do
  title
end

Drama.blueprint do
  category
  title
end

Episode.blueprint do
  drama
  num
  title
end

Watch.blueprint do
  user
  episode
  content
end

user = User.make
friends = (1..3).map{ |i| User.make }

local = Category.make(:title => "国内ドラマ")
global = Category.make(:title => "海外ドラマ")

local_dramas = (1..2).map{ |i| Drama.make(:category => local) }
global_dramas = (1..2).map{ |i|  Drama.make(:category => local) }

[local_dramas, global_dramas].flatten.each do |drama|
  Episode.make(:drama => drama)
  Sham.reset
end

episode = local_dramas.rand.episodes.rand
Watch.make(:episode => episode, :user => user)

episode = local_dramas.rand.episodes.rand
Watch.make(:episode => episode, :user => friends.first)
