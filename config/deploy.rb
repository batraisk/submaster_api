# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

require 'capistrano-db-tasks'

set :application, 'submaster_api'
set :repo_url, 'git@github.com:batraisk/submaster_api.git'
set :deploy_to, '/home/deploy/submaster_api'
set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 3
set :keep_assets, 3

set :db_local_clean, true
set :db_remote_clean, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console do |current_task|
    on roles(:app) do |server|
      server ||= find_servers_for_task(current_task).first
      exec %Q[ssh -l #{server.user||fetch(:user)} #{server.hostname} -p #{server.port || 22} -t 'export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"; cd #{release_path}; bin/rails console -e production']
    end
  end
end