require File.expand_path('../boot', __FILE__)

Bundler.require :default, ENV['RACK_ENV']

require File.expand_path('../../api/api', __FILE__)

