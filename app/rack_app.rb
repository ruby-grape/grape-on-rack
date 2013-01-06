module Rackup
  class << self
    def app
      @app ||= Rack::Builder.new do
        use Rack::Session::Cookie
        Warden::Manager.serialize_into_session { |user| user.id }
        Warden::Manager.serialize_from_session { |id| User.get(id) }
        use Warden::Manager do |manager|
          manager.default_strategies :password, :basic
          manager.failure_app = Acme::BadAuthentication
        end
        run Acme::App.new
      end
    end
  end
end


