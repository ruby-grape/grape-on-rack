require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Rackup::app.to_app
  end
    
  context "v1" do
    it "should get warden" do

      # This test fails but viewing this same method in the browser will produce something like this:
      # {"warden":"Warden::Proxy:70269128074280 @config={:default_scope=>:default, :scope_defaults=>{}, :default_strategies=>{:_all=>[:password, :basic]}, :intercept_401=>true, :failure_app=>Acme::BadAuthentication}"}
      get 'api/v1/warden' do
        JSON.parse(last_response.body)['warden'].should_not be_nil
      end
    end

    context "system" do
      it "ping" do
        get "/api/v1/system/ping"
        last_response.body.should == { :ping => "pong" }.to_json
      end
    end
  end

end

