module Acme
  class App
    def initialize
      @filenames = [ '', '.html', 'index.html', '/index.html' ]
      @rack_static = ::Rack::Static.new(
        lambda { [404, {}, []] }, {
          :root => File.expand_path('../../public', __FILE__),
          :urls => %w[/]
        })
    end
    def call(env)
      request_path = env['PATH_INFO']      
      # static files
      @filenames.each do |path|
        response = @rack_static.call(env.merge({'PATH_INFO' => request_path + path}))
        return response if response[0] != 404
      end
      # api
      response = Acme::API.call(env)
      # error pages
      case response[0]
      when 404, 500
        @rack_static.call(env.merge({'PATH_INFO' => "/errors/#{response[0]}.html"}))
      else
        response
      end
    end
  end
end


