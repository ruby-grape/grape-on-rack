module Acme
  class Wrap_Response_Decorator
    def initialize(app)
      @app = app
    end
    def call(env)
      status, headers, body_proxy = @app.call(env)
      bodies = body_proxy.body.map do |body|
        { :body => JSON.parse(body), :status => status }.to_json
      end
      [ 200, headers, bodies ]
    end
  end
end

