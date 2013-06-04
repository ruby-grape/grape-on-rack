module Acme
  class API_v7 < Grape::API
    version 'v7', :using => :path
    format :json
    desc "Upload an image."
    post "avatar" do
      {
        filename: params[:image_file][:filename],
        size: params[:image_file][:tempfile].size
      }
    end
  end
end
