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

dramas = {"アグリー・ベティ シーズン1" => { :episodes => ["あこがれの出版業界","普通が一番","クイーンズの絆","『モード』のルール","疑惑のオルゴール","父の告白","親子のきずな","夢への第一歩","悲喜こもごもの感謝祭","思わぬチャンス","運命を感じる瞬間","ソフィアの素顔","暴かれた正体","カミングアウト","ミード家の闇","裏切り","母の決断","家族というもの","フェイの日記","表紙モデルの陰謀","秘書の日","グアダラハラの木","イースト・サイド物語"], :title_image => "ugly_betty_1.gif"},
  "アグリー・ベティ シーズン2" => { :episodes => ["悲しみを越えて","亡き人の思い出","ブラック＆ホワイト","女は強し","揺らぐ心","大切な人との時間","愛を貫いて","母の思い 父の願い","新生『モード』","サバイバル・ゲーム","ベティの革命","クレアの香水","パパに捧げる歌","24回目のバースデー","燃えるような恋","ふたつの命","ベティの生き方","明日へのジャンプ"], :title_image => "ugly_betty_2.gif" },
  "LOST シーズン1"=>{ :episodes => ["墜落","SOS","眠れぬ夜","運命","責任","閉ざされた心","暗闇の中で","手紙","孤独の人","予言","見えない足跡","ケースの中の過去","絆","運命の子","守るべきもの","最期の言葉","沈黙の陰","数字","啓示","約束","悲しみの記憶","タイムカプセル","迫りくる脅威","暗黒地帯","漆黒の闇"], :title_image => "lost_1.gif"},
  "24 -TWENTY FOUR- シーズン1"=>{ :episodes => ["12:00-AM1:00","AM1:00-AM2:00","AM2:00-AM3:00","AM3:00-AM4:00","AM4:00-AM5:00","AM5:00-AM6:00","AM6:00-AM7:00","AM7:00-AM8:00","AM8:00-AM9:00","AM9:00-AM10:00","AM10:00-AM11:00","AM11:00-AM12:00","AM12:00-PM1:00","PM1:00-PM2:00","PM2:00-PM3:00","PM3:00-PM4:00","PM4:00-PM5:00","PM5:00-PM6:00","PM6:00-PM7:00","PM7:00-PM8:00","PM8:00-PM9:00","PM9:00-PM10:00","PM10:00-PM11:00","PM11:00-PM12:00"], :title_image => "24_1.gif" },
  "24 -TWENTY FOUR- シーズン2"=>{ :episodes => ["12:00-AM1:00","AM1:00-AM2:00","AM2:00-AM3:00","AM3:00-AM4:00","AM4:00-AM5:00","AM5:00-AM6:00","AM6:00-AM7:00","AM7:00-AM8:00","AM8:00-AM9:00","AM9:00-AM10:00","AM10:00-AM11:00","AM11:00-AM12:00","AM12:00-PM1:00","PM1:00-PM2:00","PM2:00-PM3:00","PM3:00-PM4:00","PM4:00-PM5:00","PM5:00-PM6:00","PM6:00-PM7:00","PM7:00-PM8:00","PM8:00-PM9:00","PM9:00-PM10:00","PM10:00-PM11:00","PM11:00-PM12:00"], :title_image => "24_2.gif"} }
dramas = dramas.map do |title, value|
  drama = Drama.make(:title => title, :title_image => value[:title_image])
  value[:episodes].map{ |title| Episode.make(:drama => drama, :title => title) }
  Sham.reset
end

user = User.make
friends = (1..3).map{ |i| User.make(:friend_ids => "#{user.mixi_id}") }

# episode = local_dramas.rand.episodes.rand
# Watch.make(:episode => episode, :user => user)

# episode = local_dramas.rand.episodes.rand
# Watch.make(:episode => episode, :user => friends.first)
