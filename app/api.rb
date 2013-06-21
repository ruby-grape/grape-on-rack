module Acme
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::Acme::Rescue_From
    mount ::Acme::Path_Versioning
    mount ::Acme::Header_Versioning
    mount ::Acme::Post_Put
    mount ::Acme::Wrap_Response
    mount ::Acme::Post_Json
    mount ::Acme::Content_Type
    mount ::Acme::Upload_File
    add_swagger_documentation api_version: 'v1'
  end
end

