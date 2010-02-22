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
  mixi_id { Sham.num }
  profile_image_url { "http://img.mixi.jp/img/basic/common/noimage_member76.gif" }
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

local = Category.make(:title => "アクション")
global = Category.make(:title => "ヒューマン")

# drama_titles = ["悪魔で候","アグリー・ベティ シーズン1","アグリー・ベティ シーズン2","アグリー・ベティ シーズン3","アボンリーへの道","アリー my Love シーズン1","アリー my Love シーズン2","アリー my Love シーズン3","アリー my Love シーズン4","アリー my Love シーズン5","Weeds ママの秘密 シーズン1","Weeds ママの秘密 シーズン2","Weeds ママの秘密 シーズン3","宇宙へ〜冷戦と二人の天才","詠春 The Legend of WING CHUN","Xファイル 〜The X-Files〜","OZ／オズ　第1シーズン","OZ／オズ　第2シーズン","OZ／オズ　第3シーズン","OZ／オズ　第4シーズン","KYLE＜カイル＞XY シーズン1","KYLE＜カイル＞XY シーズン2","カムバック!スネさん","The Guild／ギルド","The Closer/クローザー シーズン1","ゴースト〜天国からのささやき シーズン1","ゴースト〜天国からのささやき シーズン2","ゴースト〜天国からのささやき シーズン3","ゴースト〜天国からのささやき シーズン4","ザ・ホワイトハウス シーズン3","The Lost Room","THE WIRE／ザ・ワイヤー シーズン1","The O.C.","新アウター・リミッツ","新スター･トレック シーズン1","新スター･トレック シーズン2","新スター･トレック シーズン3","新スター･トレック シーズン4","SUPERNATURAL/スーパーナチュラル シーズン5","スタートレック:ヴォイジャー　シーズン1","スタートレック:ヴォイジャー　シーズン2","スタートレック:ヴォイジャー　シーズン3","スタートレック:ヴォイジャー　シーズン4","スターゲイト SG-1 シーズン1","スターゲイト SG-1 シーズン2","スターゲイト SG-1 シーズン3","スターゲイト SG-1 シーズン4","スターゲイト SG-1 シーズン5","スターゲイト SG-1 シーズン6","スターゲイト SG-1 シーズン7","スターゲイト SG-1 シーズン8","スターゲイト SG-1 シーズン9","スターゲイト SG-1 シーズン10","素晴らしき日々 シーズン2","素晴らしき日々 シーズン3","素晴らしき日々 シーズン4","素晴らしき日々 シーズン5","素晴らしき日々 シーズン6","スピン・シティ","ダーク・エンジェル シーズン1","ダーク・エンジェル シーズン2","DAMAGES/ダメージ シーズン1","DAMAGES/ダメージ シーズン2","朱蒙 -チュモン- Prince of the Legend","デクスター〜警察官は殺人鬼 シーズン1","デクスター〜警察官は殺人鬼 シーズン2","デスパレートな妻たち シーズン1","デスパレートな妻たち シーズン2","デスパレートな妻たち シーズン3","デスパレートな妻たち シーズン4","デスパレートな妻たち シーズン5","トゥルー・コーリング","24 -TWENTY FOUR- シーズン1","24 -TWENTY FOUR- シーズン2","24 -TWENTY FOUR- シーズン3","24 -TWENTY FOUR- シーズン4","24 -TWENTY FOUR- シーズン5","24 -TWENTY FOUR- シーズン6","24 -TWENTY FOUR- シーズン7","24 -TWENTY FOUR- シーズン8","Dr.HOUSE/ドクター・ハウス シーズン1","Dr.HOUSE/ドクター・ハウス シーズン2","Dr.HOUSE/ドクター・ハウス シーズン3","ドクター・フー／DOCTOR・WHO シーズン1","ドクター・フー／DOCTOR・WHO シーズン2","ナイトライダー 2008","刑事ナッシュ・ブリッジス シーズン1、2","刑事ナッシュ・ブリッジス シーズン4","刑事ナッシュ・ブリッジス シーズン5","刑事ナッシュ・ブリッジス シーズン6","NCIS〜ネイビー犯罪捜査班 シーズン1","NCIS〜ネイビー犯罪捜査班 シーズン2","NCIS〜ネイビー犯罪捜査班 シーズン3","バンド・オブ・ブラザース","ハンナ・モンタナ シークレット・アイドル シーズン1","HEROES/ヒーローズ シーズン3","HEROES/ヒーローズ シーズン4","ビバリーヒルズ高校白書 シーズン1","ビバリーヒルズ高校白書 シーズン2","ファンタスティック・カップル","4400 未知からの生還者 シーズン1","4400 未知からの生還者 シーズン2","4400 未知からの生還者 シーズン3","4400 未知からの生還者 シーズン4","冬のソナタ","フラッシュフォワード シーズン1","プリズン･ブレイク シーズン1","プリズン・ブレイク シーズン2","プリズン･ブレイク シーズン3","プリズン･ブレイク シーズン4","BONES/ボーンズ シーズン1","BONES/ボーンズ シーズン2","BONES/ボーンズ シーズン3","ボーイ・ミーツ・ワールド シーズン7","ミレニアム シーズン1","名探偵ポワロ","リ・ジェネシス バイオ犯罪捜査班　シーズン1","REAPER 〜デビルバスター〜","LAW & ORDER:犯罪心理捜査班 シーズン1","LOST シーズン1","LOST シーズン2","LOST シーズン3","LOST シーズン4","LOST シーズン5"]

drama_titles = ["アグリー・ベティ シーズン1","アグリー・ベティ シーズン2","アグリー・ベティ シーズン3", "LOST シーズン1","LOST シーズン2","LOST シーズン3","LOST シーズン4","LOST シーズン5", "24 -TWENTY FOUR- シーズン1","24 -TWENTY FOUR- シーズン2","24 -TWENTY FOUR- シーズン3"]
dramas = drama_titles.map do |drama_title|
  Drama.make(:title => drama_title)
end

dramas.each do |drama|
  (1..5).map{ |i| Episode.make(:drama => drama) }
  Sham.reset
end

user = User.make
friends = (1..3).map{ |i| User.make(:friend_ids => "#{user.mixi_id}") }

# episode = local_dramas.rand.episodes.rand
# Watch.make(:episode => episode, :user => user)

# episode = local_dramas.rand.episodes.rand
# Watch.make(:episode => episode, :user => friends.first)
