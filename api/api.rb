
module Acme

  class API < Grape::API

    version 'v1', :using => :header, :vendor => 'acme', :format => :json
    
    resource :system do

      desc "Returns pong."
      get :ping do
        "pong"
      end

    end

  end
end

