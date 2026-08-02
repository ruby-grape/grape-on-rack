module Acme
  class PathVersioning < Grape::API
    version 'vendor', using: :path, vendor: 'acme'
    desc 'Returns acme.'
    get do
      { path: 'acme' }
    end
  end
end
