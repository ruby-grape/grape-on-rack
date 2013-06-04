require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it "vendored path" do
    get "/api/vendor"
    last_response.body.should == { :path => "acme" }.to_json
  end

end

