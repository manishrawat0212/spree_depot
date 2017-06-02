# config valid only for current version of Capistrano
lock "3.8.0"

set :application, "spree_depot"
set :repo_url, "git@github.com:manishrawat0212/spree_depot.git"
set :use_sudo, false
set :keep_releases, 5

set :format, :pretty
set :log_level, :debug

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{log tmp public/assets}

namespace :deploy do
  after :restart, :restart_delayed_job do
    invoke :'delayed_job:restart'
  end
end

task_states = %w[start stop restart]

namespace :delayed_job do
  task_states.each do |command|
    desc "#{ command } delayed job"
    task command do
      on roles(:delayed_job), in: :parallel do
        within current_path do
          with rails_env: fetch(:rails_env) do
            execute :bundle, :exec, :ruby, "bin/delayed_job #{ command }"
          end
        end
      end
    end
  end
end
