require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :production

set :environment, production
set :output, environment == 'development' ? 'log/crontab.log' : '/var/www/Date_me/shared/log/crontab.log'
job_type :rake, 'export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output'

every 15.minutes do
  rake 'push:push_remind'
end

every 5.minutes do
  rake 'push:push_mission'
end