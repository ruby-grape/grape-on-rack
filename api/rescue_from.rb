module Acme
  class RescueFrom < Grape::API
    rescue_from :all do |e|
      Rack::Response.new([e.message], 500, 'Content-type' => 'text/error').finish
    end
    desc 'Raises an exception.'
    get :raise do
      fail 'Unexpected error.'
    end
  end
end
