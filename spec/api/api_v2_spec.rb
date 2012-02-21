require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end
    
  context "v2" do
    context "system" do
      it "ping" do
        get "/api/v2/system/zing"
        last_response.body.should == { :zing => "zong" }.to_json
      end
    end
  end

end

