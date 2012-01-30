require File.expand_path('../config/environment', __FILE__)

use Rack::TryStatic, 
  :root => File.expand_path('../public', __FILE__), 
  :urls => %w[/], :try => ['.html', 'index.html', '/index.html']

run Acme::API

