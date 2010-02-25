module MixiRest
  module People
    extend ActiveSupport::Memoizable

    SERVICE = "people"

    def me_self
      resp = fetch("/@me/@self")
      resp.entry if resp
    end
    memoize :me_self

    def me_friends
      fetch("/@me/@friends")
    end
    memoize :me_friends

    def fetch_friend_ids
      me_friends.entry.map do |entry|
        entry.id.split(":").last
      end
    end

    private
    def fetch(path)
      con = MixiRest::Connection.instance
      resp = con.request(self.mixi_id, "#{SERVICE}#{path}")
    end
  end
end
