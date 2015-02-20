class ConfController < ApplicationController
  def init
    app_snake_case = params[:app_name].gsub(/[\ \-]/, '_')
    app_class = app_snake_case.classify
    repo_url = params[:repo_url]
    
    CoconBuilder.change_application_rb(app_class)
    CoconBuilder.change_session_store_rb(app_snake_case)
    CoconBuilder.init_database_yml(app_snake_case)
    CoconBuilder.init_capistrano(app_snake_case, repo_url)

    CoconBuilder.change_index_haml

    redirect_to root_path
  end
end