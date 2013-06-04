require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it "ping" do
    get "/api/ping"
    last_response.status.should == 200
    last_response.body.should == { :ping => "pong" }.to_json
  end

end

