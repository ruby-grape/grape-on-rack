require File.expand_path('config/environment', __dir__)

NewRelic::Agent.manual_start

run Acme::App.instance
