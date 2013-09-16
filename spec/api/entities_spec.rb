require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it "returns exposed entity" do
    get "/api/entities/123"
    last_response.status.should == 200
    JSON.parse(last_response.body).should eq ({
      "tool" => {
        "id" => "123",
        "length" => 10,
        "weight" => "20kg"
      }
    })
  end

  it "returns exposed entity with options" do
    get "/api/entities/123?foo=bar"
    last_response.status.should == 200
    JSON.parse(last_response.body).should eq ({
      "tool" => {
        "id" => "123",
        "length" => 10,
        "weight" => "20kg",
        "foo" => "bar"
      }
    })
  end

end

