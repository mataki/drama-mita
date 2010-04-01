task :cron => ["cron:daily"]

namespace :cron do
  task :daily => [:post_usage, :clean_session_records]

  task :post_usage => :environment do
    puts "Post usage data"
    RecordUsageData.post
    puts "End post usage data"
  end

  task :clean_session_records => :environment do
    puts "[Start] Clean up session data"
    ActiveRecord::SessionStore::Session.destroy_all(['updated_at <= ?', 3.hour.ago])
    puts "[End] Clean up session data"
  end
end
