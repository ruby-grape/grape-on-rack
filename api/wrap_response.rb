require 'wrap_response_decorator'

module Acme
  class Wrap_Response < Grape::API
    use Wrap_Response_Decorator
    format :json
    namespace :decorated do
      desc "Returns pong."
      get :ping do
        { :ping => "pong" }
      end
    end
  end
end
