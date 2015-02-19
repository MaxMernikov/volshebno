class ConfController < ApplicationController
  def init
    @app_snake_case = params[:app_name].gsub(/[\ \-]/, '_')
    @app_class = @app_snake_case.classify
    @repo_url = params[:repo_url]

    change_application_rb
    change_session_store_rb
    init_database_yml
    init_capistrano

    change_index_haml

    redirect_to root_path
  end

  def change_application_rb
    file_name = 'config/application.rb'
    text = File.read(file_name)

    new_contents = text.sub('Cocon', @app_class)
    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def change_session_store_rb
    file_name = 'config/initializers/session_store.rb'
    text = File.read(file_name)

    new_contents = text.sub('cocon', @app_snake_case)
    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def init_database_yml
    file_name = 'Gemfile'
    text = File.read(file_name)

    new_contents = text.sub('sqlite3', 'pg')
    File.open(file_name, "w") {|file| file.puts new_contents }

    text = File.read('lib/cocon/config/database.yml')
    new_contents = text.gsub('cocon', @app_snake_case).sub('#point_001', SecureRandom.hex)

    File.open('config/database.yml', "w") {|file| file.puts new_contents }
  end

  def init_capistrano
    file_name = 'config/deploy/staging.rb'
    text = File.read(file_name)

    new_contents = text.sub('cocon', @app_snake_case.gsub('_', '.'))
    File.open(file_name, "w") {|file| file.puts new_contents }


    file_name = 'config/deploy.rb'
    text = File.read(file_name)

    new_contents = text.sub('#point_001', @repo_url)
    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def change_index_haml
    file_name = 'app/views/pages/index.haml'

    new_contents = "%h1 almost done!\n\nnow restart your application"
    File.open(file_name, "w") {|file| file.puts new_contents }
  end
end