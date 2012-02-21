require 'spec_helper'

describe "Grape on RACK", :js => true, :type => :request do
  context "homepage" do
    before :each do
      visit "/"
    end
    it "displays index.html page" do
      page.find("title").text.should == "Rack Powers Web APIs"
    end
    context "ring" do
      before :each do
        @rang = Acme::API_v3.class_variable_get(:@@rang)
      end
      it "increments the ring counter" do
        page.find("#ring_value").should have_content "rang #{@rang} time(s), click here to ring again"
        3.times do |i|
          page.find("#ring_value").click
          page.find("#ring_value").should have_content "rang #{@rang + i + 1} time(s), click here to ring again"
        end
      end
    end
  end
end

