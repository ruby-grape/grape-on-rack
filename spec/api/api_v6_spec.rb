require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context "v6" do
    it "returns plain text content" do
      get "/api/v6/data"
      last_response.status.should == 200
      last_response.body.should == "A red brown fox jumped over the road."
    end
  end

end

