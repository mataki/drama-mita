task :cron => ["cron:daily"]

namespace :cron do
  task :daily => [:post_usage]
  task :post_usage => :environment do
    puts "Post usage data"
    RecordUsageData.post
    puts "End post usage data"
  end
end
