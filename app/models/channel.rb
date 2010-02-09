class Channel
  CHANNELS = [:fuji, :tbs, :ntv, :tva, :nhk].freeze
  NAME_HASH = { :fuji => "フジテレビ", :tbs => "TBS", :ntv => "日本テレビ",
    :tva => "テレビ朝日", :nhk => "NHK" }

  def self.keys
    CHANNELS
  end

  def self.names
    keys.map do |key|
      NAME_HASH[key]
    end
  end

  def self.each &block
    keys.map do |key|
      yield(key, NAME_HASH[key])
    end
  end
end
