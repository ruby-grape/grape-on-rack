require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context "v5" do
    [ true, false ].each do |reticulated|
      it "POST #{reticulated ? 'reticulated' : 'unreticulated' } spline" do
  	    post "/api/v5/spline", { 'reticulated' => reticulated }
  	    last_response.status.should == 201
  	    JSON.parse(last_response.body).should == { "reticulated" => reticulated.to_s }
  	  end
    end
  end

end
