require 'spec_helper'
require 'tempfile'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'streams the upload and download of a large file' do
    data = SecureRandom.random_bytes((Acme::FileStreamer::CHUNK_SIZE * 2.5).to_i)
    Tempfile.create(['large_file', '.bin']) do |file|
      file.binmode
      file.write(data)
      file.rewind

      post '/api/download_stream', file: Rack::Test::UploadedFile.new(file.path, 'application/octet-stream', true)
      expect(last_response.status).to eq(201)
      expect(last_response.headers).to include('Content-Type' => 'application/octet-stream', 'Content-Disposition' => "attachment; filename*=UTF-8''#{File.basename(file.path)}")
      expect(last_response.body.bytesize).to eq(data.bytesize)
      expect(last_response.body).to eq data
    end
  end
end
