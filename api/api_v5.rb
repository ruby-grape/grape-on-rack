require 'api_v4_decorator'

module Acme
  class API_v5 < Grape::API
    version 'v5', :using => :path, :vendor => 'acme', :format => :json
    desc "Creates a spline that can be reticulated."
    resource :spline do
	  post do
	  	{ :reticulated => params[:reticulated] }
	  end
    end
  end
end

