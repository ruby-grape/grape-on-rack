require 'api_v4_decorator'

module Acme
  class API_v4 < Grape::API
    use API_v4_Decorator
    version 'v4', :using => :path, :vendor => 'acme', :format => :json
    desc "Returns pong."
    get :ping do
      { :ping => "pong" }
    end
  end
end

