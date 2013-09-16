module Acme
  module Entities

    class Tool < Grape::Entity
      root "tools", "tool"
      expose :id
      expose :length
      expose :weight
      expose :foo, :if => lambda { |tool, options| options[:foo] } do |tool, options|
        # p options[:env].keys
        options[:foo]
      end
    end

    class API < Grape::API
      format :json
      desc "Exposes an entity"
      namespace :entities do
        get ':id' do
          present OpenStruct.new(id: params[:id], length: 10, weight: "20kg"), with: Acme::Entities::Tool, foo: params[:foo]
        end
      end
    end

  end
end
