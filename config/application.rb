$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV.fetch('RACK_ENV', nil)

Dir[File.expand_path('../api/*.rb', __dir__)].sort.each do |f|
  require f
end

require 'api'
require 'acme_app'
