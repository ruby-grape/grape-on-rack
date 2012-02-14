require File.expand_path('../boot', __FILE__)

Bundler.require :default, ENV['RACK_ENV']

require File.expand_path('../../api/api_v1.rb', __FILE__)
require File.expand_path('../../api/api_v2.rb', __FILE__)
require File.expand_path('../../api/api.rb', __FILE__)

