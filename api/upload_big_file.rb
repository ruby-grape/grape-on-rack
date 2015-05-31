module Acme
  class UploadBigFile < Grape::API
    content_type :png, 'image/png'

    desc 'Upload and download a big file of any format using IO.'
    post 'big_download' do
      filename = params[:file][:filename]
      # content_type MIME::Types.type_for(filename)[0].to_s
      content_type 'image/png'
      env['api.format'] = :png
      header 'Content-Disposition', "attachment; filename*=UTF-8''#{URI.escape(filename)}"

      temp_file = params[:file][:tempfile]
      body FileStreamer.new temp_file.path
      nil
    end
  end

  class FileStreamer
    def initialize(file_path)
      @file_path = file_path
    end

    def each(&blk)
      File.open(@file_path, 'r') do |file|
        file.each(10, &blk)
      end
    end
  end
end
