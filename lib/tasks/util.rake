namespace :util do
  task :import_drama_list => :environment do
    puts "Import start"
    require File.expand_path('../../import_drama_list.rb', __FILE__)
    puts "End import"
  end
end
