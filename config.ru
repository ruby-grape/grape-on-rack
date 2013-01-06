require File.expand_path('../config/environment', __FILE__)

if ENV['RACK_ENV'] == 'development'
  puts "Loading NewRelic in developer mode ..."
  require 'new_relic/rack/developer_mode'
  use NewRelic::Rack::DeveloperMode
end

NewRelic::Agent.manual_start
use Rack::Session::Cookie
Warden::Manager.serialize_into_session { |user| user.id }
Warden::Manager.serialize_from_session { |id| User.get(id) }
use Warden::Manager do |manager|
  manager.default_strategies :password, :basic
  manager.failure_app = Acme::BadAuthentication
end
run Acme::App.new
