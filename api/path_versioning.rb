module Acme
  class Path_Versioning < Grape::API
    version 'vendor', :using => :path, :vendor => 'acme', :format => :json
    desc "Returns acme."
    get do
      { :path => "acme" }
    end
  end
end
