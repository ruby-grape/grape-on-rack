module Acme
  class API_v1 < Grape::API
    version 'v1', :using => :path, :vendor => 'acme', :format => :json
    rescue_from :all do |e|
      Rack::Response.new([ e.message ], 500, { "Content-type" => "text/error" }).finish
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
