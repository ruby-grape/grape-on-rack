require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it "uploads a file" do
    image_filename = "spec/fixtures/grape_logo.png"
    post "/api/avatar", image_file: Rack::Test::UploadedFile.new(image_filename, 'image/png', true)
    last_response.status.should == 201
    last_response.body.should == {
      "filename" => "grape_logo.png",
      "size" => File.size(image_filename)
    }.to_json
  end

  it "uploads and downloads a PNG file" do
    image_filename = "spec/fixtures/grape_logo.png"
    post "/api/download.png", file: Rack::Test::UploadedFile.new(image_filename, 'image/png', true)
    last_response.status.should == 201
    last_response.headers['Content-Type'].should == "image/png"
    last_response.headers['Content-Disposition'].should == "attachment; filename*=UTF-8''grape_logo.png"
    File.open(image_filename, 'rb') do |io|
      last_response.body.should eq io.read
    end
  end

  it "uploads and downloads a Ruby file" do
    filename = __FILE__
    post "/api/download.rb", file: Rack::Test::UploadedFile.new(filename, 'application/x-ruby', true)
    last_response.status.should == 201
    last_response.headers['Content-Type'].should == "application/x-ruby"
    last_response.headers['Content-Disposition'].should == "attachment; filename*=UTF-8''upload_file_spec.rb"
    File.open(filename, 'rb') do |io|
      last_response.body.should eq io.read
    end
  end
end
