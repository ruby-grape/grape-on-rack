module Acme
  class API_v1 < Grape::API
    version 'v1', :using => :path, :vendor => 'acme', :format => :json
    resource :system do
      desc "Returns pong."
      get :ping do
        "pong"
      end
    end
  end
end
