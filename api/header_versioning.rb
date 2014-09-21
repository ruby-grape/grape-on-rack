module Acme
  class HeaderVersioning < Grape::API
    version 'v1', using: :header, vendor: 'acme', format: :json, strict: true
    desc 'Returns acme.'
    get do
      { header: 'acme' }
    end
  end
end
