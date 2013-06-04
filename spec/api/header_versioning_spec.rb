require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context "header based versioning" do
    it "vendored header" do
      get "/api", nil, { "HTTP_ACCEPT" => "application/vnd.acme-v1+json" }
      last_response.status.should == 200
      last_response.body.should == { :header => "acme" }.to_json
    end
    it "invalid version" do
      get "/api", nil, { "HTTP_ACCEPT" => "application/vnd.acme-v2+json" }
      last_response.status.should == 404
    end
  end

end

