# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "kepasa"
set :repo_url, "git@github.com:kepasa-project/kepasa-feeds-aggregator.git"

#############################################################
# RBENV
#############################################################

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

set :rails_env, :production

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

set :migration_role, :app
set :assets_role, :app
set :deploy_to, ENV['PRO_WEBAPP_PATH']

# Default value for :pty is false
set :pty, true

append :linked_files, "config/database.yml", "config/application.yml", "config/secrets.yml"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/uploads"

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :rails do
  desc "Open the rails console"
  task :console do
    on roles(:app) do
      rails_env = fetch(:rails_env, 'production')
      execute_interactively "$HOME/.rbenv/bin/rbenv exec bundle exec rails console #{rails_env}"
    end
  end

  desc "Open the rails dbconsole"
  task :dbconsole do
    on roles(:app) do
      rails_env = fetch(:rails_env, 'production')
      execute_interactively "$HOME/.rbenv/bin/rbenv exec bundle exec rails dbconsole #{rails_env}"
    end
  end
  
  desc "restart sidekiq"
  task :restart_sidekiq do
    on roles(:app) do
     #execute :sudo, :systemctl, :restart, :sidekiq
     execute_interactively "systemctl restart sidekiq"
    end
  end
  
  desc "restart redis"
  task :restart_redis do
    on roles(:app) do
     execute_interactively "service redis_6379 restart"
    end
  end

  def execute_interactively(command)
    host = ENV['WEB_IP_ADDRESS']
    user = ENV['WEB_USER']
    port = fetch(:port) || ENV['WEB_SSH_PORT']
    exec "ssh -l #{user} #{host} -p #{port} -t 'cd #{deploy_to}/current && #{command}'"
  end
end