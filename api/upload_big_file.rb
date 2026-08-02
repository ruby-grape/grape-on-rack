module Acme
  class FileStreamer
    CHUNK_SIZE = 10_240

    def initialize(file_path)
      @file_path = file_path
    end

    def each(&block)
      File.open(@file_path, 'rb') do |file|
        file.each(CHUNK_SIZE, &block)
      end
    end
  end

  class UploadBigFile < Grape::API
    desc 'Upload and download a large file of any format using an IO stream.'
    post 'download_stream' do
      filename = params[:file][:filename]
      content_type MIME::Types.type_for(filename)[0].to_s
      env['api.format'] = :binary
      header 'Content-Disposition', "attachment; filename*=UTF-8''#{CGI.escape(filename)}"
      stream FileStreamer.new(params[:file][:tempfile].path)
    end
  end
end
