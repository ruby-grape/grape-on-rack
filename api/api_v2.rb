module Acme
  class API_v2 < Grape::API
    version 'v2', :using => :path, :vendor => 'acme', :format => :json
    resource :system do
      desc "Returns zong."
      get :zing do
        { :zing => "zong" }
      end
    end
  end
end
