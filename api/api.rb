module Acme
  class API < Grape::API
    mount ::Acme::API_v1
    mount ::Acme::API_v2
  end
end

