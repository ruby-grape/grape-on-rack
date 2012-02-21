module Acme
  class API_v3 < Grape::API
    @@rang = 0
    version 'v3', :using => :path, :vendor => 'acme', :format => :json
    resource :system do
      desc "Returns pong."
      get :ring do
        { :rang => @@rang }
      end
      post :ring do
        @@rang += 1
        { :rang => @@rang }
      end
      put :ring do
        error!("missing :count", 400) unless params[:count]
        @@rang += params[:count].to_i
        { :rang => @@rang }
      end
    end
  end
end

