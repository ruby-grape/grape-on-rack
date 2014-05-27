module Acme
  class UploadFile < Grape::API
    format :json

    content_type :png, "application/png"
    content_type :rb, "application/x-ruby"

    desc "Upload an image."
    post "avatar" do
      {
        filename: params[:image_file][:filename],
        size: params[:image_file][:tempfile].size
      }
    end

    desc "Upload and download a file of any format."
    post "download" do
      filename = params[:file][:filename]
      content_type MIME::Types.type_for(filename)[0].to_s
      header "Content-Disposition", "attachment; filename*=UTF-8''#{URI.escape(filename)}"
      params[:file][:tempfile].read
    end
  end
end
