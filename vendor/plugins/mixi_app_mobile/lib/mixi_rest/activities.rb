module MixiRest
  module Activities
    SERVICE = "activities"

    def self.request(mixi_id, title, url, media_items = nil)
      data = { "title" => title, "mobileUrl" => url, "mediaItems" => media_items }
      con = MixiRest::Connection.instance
      resp = con.request(mixi_id, "#{SERVICE}/@me/@self/@app", :post, {}, data.to_json, { 'Content-Type' => 'application/json' })
    end

  end
end
