set :rails_env, fetch(:stage)
set :deploy_to, "/var/www/spree_depot"
set :branch, ENV.fetch('branch', 'master')

server "34.211.92.176", user: "deploy"
