task :deploy => ['deploy:push', 'deploy:restart', 'deploy:tag']

namespace :deploy do
  task :migrations => [:push, :off, :migrate, :restart, :on, :tag]
  task :rollback => [:off, :push_previous, :restart, :on]

  task :push do
    puts 'Deploying site to Heroku ...'
    puts `git push heroku`
  end

  task :restart do
    puts 'Restarting app servers ...'
    puts `heroku restart`
  end

  task :tag do
    release_name = "release-#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
    puts "Tagging release as '#{release_name}'"
    puts `git tag -a #{release_name} -m 'Tagged release'`
    puts `git push --tags heroku`
  end

  task :migrate do
    puts 'Running database migrations ...'
    puts `heroku rake db:migrate`
  end

  task :off do
    puts 'Putting the app into maintenance mode ...'
    puts `heroku maintenance:on`
  end

  task :on do
    puts 'Taking the app out of maintenance mode ...'
    puts `heroku maintenance:off`
  end

  task :push_previous do
    releases = `git tag`.split("\n").select { |t| t[0..7] == 'release-' }.sort
    current_release = releases.last
    previous_release = releases[-2] if releases.length >= 2
    if previous_release
      puts "Rolling back to '#{previous_release}' ..."
      puts `git push -f heroku #{previous_release}:master`
      puts "Deleting rollbacked release '#{current_release}' ..."
      puts `git tag -d #{current_release}`
      puts `git push heroku :refs/tags/#{current_release}`
      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
      puts releases
    end
  end
end
