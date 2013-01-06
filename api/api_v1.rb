module Acme
  module Helpers
    def warden
      env['warden']
    end

    def authenticated
      if warden.authenticated?
        return true
      else
        error!('401 Unauthorized', 401)
      end
    end

    def current_user
        warden.user
    end

    def authenticated_user
      authenticated
      error!('401 Unauthorized', 401) unless current_user
    end

  end

  class API_v1 < Grape::API
    helpers ::Acme::Helpers
    version 'v1', :using => :path, :vendor => 'acme', :format => :json
    rescue_from :all do |e|
      Rack::Response.new([ e.message ], 500, { "Content-type" => "text/error" }).finish
    end
    get :warden do
      { :warden => env['warden'] }
    end

    resource :system do
      desc "Returns pong."
      get :ping do
        { :ping => "pong" }
      end
      desc "Raises an exception."
      get :raise do
        raise "Unexpected error."
      end
    end
  end
end
