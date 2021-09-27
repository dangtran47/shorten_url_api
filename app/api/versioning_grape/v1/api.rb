module VersioningGrape
  module V1
    class API < ::Grape::API
      version "v1", using: :path, vendor: 'versioning-grape'
      format :json
      mount BaseAPI

      resource :test_v1 do
        desc 'test api v1'
        get do
          {status: "ok", version: "v1"}
        end
      end
    end
  end
end
