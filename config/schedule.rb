require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :production

set :environment, rails_env

every 15.minutes do
  rake 'push:push_remind'
end

every 5.minutes do
  rake 'push:push_mission'
end