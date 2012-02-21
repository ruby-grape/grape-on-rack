require 'spec_helper'

describe "Grape on RACK", :js => true, :type => :request do
  context "homepage" do
    before :each do
      visit "/"
    end
    it "displays index.html page" do
      page.find("title").text.should == "Rack Powers Web APIs"
    end
    it "links to api ping" do
      click_link "Ping!"
      current_path.should == "/api/v1/system/ping.json"
    end
  end
  context "api/v1/system/ping.json" do
    it "displays pong" do
      visit "/api/v1/system/ping.json"
      page.should have_content '{"ping":"pong"}'
    end
  end
end

