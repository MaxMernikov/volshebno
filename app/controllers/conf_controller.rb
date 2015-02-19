class ConfController < ApplicationController
  def init
    app_snake_case = params[:app_name].gsub(/[\ \-]/, '_')
    app_class = app_snake_case.classify

    # change_application_rb(app_class)
    change_session_store_rb(app_snake_case)
    # change_index_haml

    redirect_to root_path(app_snake_case)
  end

  def change_application_rb(app_class)
    file_name = 'config/application.rb'
    text = File.read(file_name)

    new_contents = text.sub('Cocon', app_class)

    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def change_session_store_rb(app_snake_case)
    file_name = 'config/initializers/session_store.rb'
    text = File.read(file_name)

    new_contents = text.sub('cocon', app_snake_case)

    File.open(file_name, "w") {|file| file.puts new_contents }
  end

  def change_index_haml
    file_name = 'app/views/pages/index.haml'
    text = File.read(file_name)

    new_contents = "%h1 almost done!\n\nnow restart your application"

    File.open(file_name, "w") {|file| file.puts new_contents }
  end
end