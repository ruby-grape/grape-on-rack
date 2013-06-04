module Acme
  class Rescue_From < Grape::API
    format :json
    get '/ping' do
      { :ping => "pong" }
    end
  end
end
