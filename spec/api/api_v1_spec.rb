require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end
    
  context "v1" do
    context "system" do
      it "ping" do
        get "/api/v1/system/ping"
        last_response.body.should == "pong"
      end
    end
  end

end

