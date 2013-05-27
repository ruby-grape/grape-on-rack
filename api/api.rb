module Acme
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::Acme::API_v1
    mount ::Acme::API_v2
    mount ::Acme::API_v3
    mount ::Acme::API_v4
    mount ::Acme::API_v5
    mount ::Acme::API_v6
  end
end

