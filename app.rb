class App < Sinatra::Base
  register Sinatra::ConfigFile
  set :show_exceptions, false
  set :root, File.dirname(__FILE__)
  set :environments, %w{development test production staging}
  config_file 'config.yml'

  configure :development do
    register Sinatra::Reloader
    also_reload "#{Dir.pwd}/models/*"
    also_reload "#{Dir.pwd}/views/*"
  end

  before do
    content_type :json
    if params[:project_id]
      @project = Project.active.find_by_name(params[:project_id])
      error 404 unless @project
    end
  end

  get '/' do
    { app: 'kickpuncher' }.to_json
  end

  not_found do
    content_type :json
    { message: 'Not found' }.to_json
  end

  error do
    { message: env['sinatra.error'].message }.to_json
  end

  helpers do
    def authorize(project, route)
      # binding.pry
      error 401 unless project.has_permission?(route)
    end

    def decode_signed_request(signed_request, app_id, app_secret)
      if signed_request
        oauth = Koala::Facebook::OAuth.new(app_id, app_secret)
        return oauth.parse_signed_request(signed_request)
      end
    end

    def get_access_token
      oauth = Koala::Facebook::OAuth.new(@project.facebook_app_id, @project.facebook_app_secret)
      oauth.get_app_access_token
    end
  end
end