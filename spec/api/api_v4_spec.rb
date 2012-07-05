require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end
    
  context "v4" do
    it "GET ping wraps body" do
      get "/api/v4/ping"
      last_response.status.should == 200
      JSON.parse(last_response.body).should == { "body" => { "ping" => "pong" }, "status" => 200 }
    end
  end

end

