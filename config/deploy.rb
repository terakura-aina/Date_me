# config valid for current version and patch releases of Capistrano
lock "~> 3.15.0"

set :nginx_downstream_uses_ssl, true
set :application, "Date_me"
set :repo_url, "git@github.com:terakura-aina/Date_me.git" # 自身のリモートリポジトリURL
set :user, 'aina'
set :deploy_to, "/var/www/Date_me"
set :linked_files, %w[config/master.key config/database.yml .env]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/system vendor/bundle]
set :rbenv_ruby, File.read('.ruby-version').strip
set :puma_threds, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix:///var/www/Date_me/shared/tmp/sockets/puma.sock"
set :puma_state, "/var/www/Date_me/shared/tmp/pids/puma.state"
set :puma_pid, "/var/www/Date_me/shared/tmp/pids/puma.pid"
set :puma_access_log, "/var/www/Date_me/shared/log/puma.error.log"
set :puma_error_log, "/var/www/Date_me/shared/log/puma.access.log"
set :puma_preload_app, true
set :branch, ENV['BRANCH'] || "main"
set :puma_systemctl_bin, '/usr/bin/systemctl'
set :puma_systemctl_user, :system
set :whenever_command, "bundle exec whenever"
set :environments "production"

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir /var/www/Date_me/shared/tmp/sockets -p"
#       execute "mkdir /var/www/Date_me/shared/tmp/pids -p"
#     end
#   end

#   before :start, :make_dirs
# end

namespace :deploy do
  desc 'upload important files'
  task :upload do
    on roles(:app) do
      sudo :mkdir, '-p', "/var/www/Date_me/shared/config"
      sudo %[chown -R #{fetch(:user)}.#{fetch(:user)} /var/www/#{fetch(:application)}]
      sudo :mkdir, '-p', '/etc/nginx/sites-enabled'
      sudo :mkdir, '-p', '/etc/nginx/sites-available'

      upload!('.env.production', "/var/www/Date_me/shared/.env")
      upload!('config/database.yml', "/var/www/Date_me/shared/config/database.yml")
      upload!('config/master.key', "/var/www/Date_me/shared/config/master.key")
    end
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  before :starting, :upload
  before 'check:linked_files', 'puma:nginx_config'
end

after 'deploy:published', 'nginx:restart'
before 'deploy:migrate', 'deploy:db_create'
