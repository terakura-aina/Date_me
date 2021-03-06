require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :production

set :environment, production
set :output, 'log/crontab.log'

every 15.minutes do
  rake 'push:push_remind'
end

every 5.minutes do
  rake 'push:push_mission'
end