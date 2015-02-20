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
  end

  def self.init_database_yml(app_snake_case)
    file_name = 'Gemfile'
    text = File.read(file_name)

    new_contents = text.sub('sqlite3', 'pg')
    File.open(file_name, "w") {|file| file.puts new_contents }

    text = File.read('lib/cocon/config/database.yml')
    new_contents = text.gsub('cocon', app_snake_case).sub('#point_001', SecureRandom.hex)

    File.open('config/database.yml', "w") {|file| file.puts new_contents }
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
  end

  def self.add_admin_panel
    # install devise
    file_name = 'Gemfile'
    text = File.read(file_name)

    new_contents = text.sub('# cocon-end', "gem 'devise'\n# cocon-end")
    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def self.change_index_haml
    file_name = 'app/views/pages/index.haml'

    new_contents = "%h1 almost done!\n\nnow restart your application"
    File.open(file_name, "w") {|file| file.puts new_contents }
  end
end