# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "afriends"
set :repo_url, "git@github.com:satyampawar/afriends.git"
set :deploy_to, '/home/deploy/afriends'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


namespace :deploy do


  after :restart, :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
        # Here we can do anything such as:
        # within release_path do
        #   execute :rake, 'cache:clear'
        # end
        execute :touch, 'RAILS_ENV=production rackup private_pub.ru -s thin -E production &'
        # execute :touch, 'RAILS_ENV=production /home/deploy/production/SouFudao/current/bin/delayed_job restart'
        execute :touch, 'sudo service nginx restart'

        # execute 'cd /home/ubuntu/Trusttd/current; RAILS_ENV=production bundle exec rake db:migrate'
        # execute 'cd /home/ubuntu/Trusttd/current; RAILS_ENV=development bundle install'
       # execute 'sudo service nginx restart'
      end
    end
    after :publishing, :restart 
end