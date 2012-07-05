module Acme
  class API_v4_Decorator
    def initialize(app)
      @app = app       
    end                
    def call(env)
      status, headers, bodies = @app.call(env)
      bodies = bodies.map do |body|
        { :body => body, :status => status }
      end
      [ 200, headers, bodies ]
    end
  end
end

