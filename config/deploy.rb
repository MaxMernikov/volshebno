set :application, 'mastercard-lounge'
set :repo_url, 'git@github.com:MaxMernikov/volshebno.git'
set :scm, :git
set :ssh_options, { :forward_agent => true }
set :keep_releases, 3

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/ckeditor_assets}

# set :linked_files, %w{config/database.yml config/aws.yml}

set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

