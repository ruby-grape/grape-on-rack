require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end
    
  context "v3" do
    context "system" do
      it "GET ring" do
        get "/api/v3/system/ring"
        JSON.parse(last_response.body)[:rang].to_i.should >= 0
      end
      context "with rings" do
        before :each do
          get "/api/v3/system/ring"
          @rang = JSON.parse(last_response.body)["rang"].to_i
        end
        it "POST ring" do
          2.times do |i|
            post "/api/v3/system/ring"
            last_response.status.should == 201
            last_response.body.should == { :rang => @rang + i + 1 }.to_json
          end
          get "/api/v3/system/ring"
          last_response.body.should == { :rang => @rang + 2 }.to_json
        end
        it "PUT ring" do
          put "/api/v3/system/ring?count=2"
          last_response.status.should == 200
          last_response.body.should == { :rang => @rang + 2 }.to_json
        end
      end
    end
  end

end

