require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context "plain_text" do
    it "returns plain text" do
      get "/api/plain_text"
      last_response.status.should == 200
      last_response.headers['Content-Type'].should == "text/plain"
      last_response.body.should == "A red brown fox jumped over the road."
    end
  end

  context "mixed" do
    it "returns json" do
      get "/api/mixed.json"
      last_response.status.should == 200
      last_response.headers['Content-Type'].should == "application/json"
      last_response.body.should == { data: "A red brown fox jumped over the road." }.to_json
    end

    it "returns xml" do
      get "/api/mixed.xml"
      last_response.status.should == 200
      last_response.headers['Content-Type'].should == "application/xml"
      last_response.body.should == { data: "A red brown fox jumped over the road." }.to_xml
    end

    it "returns text" do
      get "/api/mixed.txt"
      last_response.status.should == 200
      last_response.headers['Content-Type'].should == "text/plain"
      last_response.body.should == { data: "A red brown fox jumped over the road." }.to_s
    end
  end
end
