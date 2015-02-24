set :stage, :staging

set :branch, 'develop'

set :deploy_to, '/home/webmaster/www/staging/staging.volshebno.projects.digitalizm.com/www/'

set :rails_env, 'staging'

set :ssh_options, {
  forward_agent: true,
  port: 22421
}

role :app, %w{webmaster@178.159.249.148}
role :web, %w{webmaster@178.159.249.148}
role :db, %w{webmaster@178.159.249.148}

server '178.159.249.148', user: 'webmaster', roles: %w{app web db}

