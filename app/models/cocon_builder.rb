class CoconBuilder
  def self.change_application_rb(app_class)
    file_name = 'config/application.rb'
    text = File.read(file_name)

    new_contents = text.sub('Cocon', app_class)
    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def self.change_session_store_rb(app_snake_case)
    file_name = 'config/initializers/session_store.rb'
    text = File.read(file_name)

    new_contents = text.sub('cocon', app_snake_case)
    File.open(file_name, "w") {|file| file.puts new_contents }

    ap 'init session_store'
  end

  def self.init_database_yml(app_snake_case)
    file_name = 'Gemfile'
    text = File.read(file_name)

    new_contents = text.sub('sqlite3', 'pg')
    File.open(file_name, "w") {|file| file.puts new_contents }

    text = File.read('lib/cocon/config/database.yml')
    new_contents = text.gsub('cocon', app_snake_case).sub('#point_001', SecureRandom.hex)

    File.open('config/database.yml', "w") {|file| file.puts new_contents }

    ap 'init database'
  end

  def self.init_capistrano(app_snake_case, repo_url)
    file_name = 'config/deploy/staging.rb'
    text = File.read(file_name)

    new_contents = text.sub('cocon', app_snake_case.gsub('_', '.'))
    File.open(file_name, "w") {|file| file.puts new_contents }


    file_name = 'config/deploy.rb'
    text = File.read(file_name)

    new_contents = text.sub('#point_001', repo_url)
    File.open(file_name, "w") {|file| file.puts new_contents }

    ap 'init capistrano'
  end

  def self.add_admin_panel
    # install devise
    %x(/bin/bash -l -c 'cd #{Rails.root} && bin/rails generate devise:install')

    # change config
    file_name = 'config/initializers/devise.rb'
    text = File.read(file_name)
    new_contents = text.sub("# config.secret_key", 'config.secret_key')
    File.open(file_name, "w") {|file| file.puts new_contents }

    ap 'init devise'


    file_name = 'config/routes.rb'
    text = File.read(file_name)
    new_contents = text.sub('Rails.application.routes.draw do', "Rails.application.routes.draw do\n  devise_for :admins, path: 'admin',\n    controllers: { sessions: \"admin/sessions\" },\n    skip: [ :registration ]\n")

    new_contents = new_contents.sub("root 'pages#index'", "namespace 'admin' do\n    root 'dashboards#index'\n  end")

    File.open(file_name, "w") {|file| file.puts new_contents }

    # copy files
    FileUtils.mkdir('db/migrate') unless Dir.exists?('db/migrate')
    FileUtils.cp('lib/cocon/admin/migrate/20150220102726_devise_create_admins.rb', 'db/migrate/20150220102726_devise_create_admins.rb')
    FileUtils.cp('lib/cocon/admin/models/admin.rb', 'app/models/admin.rb')
    FileUtils.cp('lib/cocon/admin/models/admin.rb', 'app/assets/javascripts/admin.js')

    FileUtils.mkdir('app/controllers/admin') unless Dir.exists?('app/controllers/admin')
    FileUtils.cp_r('lib/cocon/admin/controllers/admin/.', 'app/controllers/admin', :verbose => true)

    FileUtils.cp('lib/cocon/admin/helpers/admin_helper.rb', 'app/helpers/admin_helper.rb')

    FileUtils.mkdir('app/views/admin') unless Dir.exists?('app/views/admin')
    FileUtils.cp_r('lib/cocon/admin/views/admin/.', 'app/views/admin', :verbose => true)

    FileUtils.mkdir('app/assets/javascripts/admin')
    FileUtils.cp('lib/cocon/admin/assets/javascripts/admin.js', 'app/assets/javascripts/admin.js')

    FileUtils.mkdir('app/assets/stylesheets/admin')
    FileUtils.cp('lib/cocon/admin/assets/stylesheets/admin.sass', 'app/assets/stylesheets/admin.sass')

    FileUtils.cp('lib/cocon/admin/views/layouts/admin.haml', 'app/views/layouts/admin.haml')
    FileUtils.cp('lib/cocon/admin/views/layouts/devise.haml', 'app/views/layouts/devise.haml')


    file_name = 'config/initializers/assets.rb'
    text = File.read(file_name)

    new_contents = text.sub('# Rails.application.config.assets.precompile += %w( search.js )', "# Rails.application.config.assets.precompile += %w( search.js )\nRails.application.config.assets.precompile += %w( admin.css admin.js )")
    File.open(file_name, "w") {|file| file.puts new_contents }


    file_name = 'Gemfile'
    text = File.read(file_name)

    new_contents = text.sub("gem 'devise' #point_001", "gem 'devise'\ngem 'bootstrap-sass', '~> 3.3.3'")
    File.open(file_name, "w") {|file| file.puts new_contents }

    ap 'init admin panel'

    text = File.read('tmp/pids/server.pid')
    %x(/bin/bash -l -c 'kill #{text}')
    ap 'kill app'
  end

  def self.change_index_haml
    file_name = 'app/views/pages/index.haml'

    new_contents = "%h1 almost done!\n\nnow restart your application"
    File.open(file_name, "w") {|file| file.puts new_contents }

    ap 'change index page'
  end
end