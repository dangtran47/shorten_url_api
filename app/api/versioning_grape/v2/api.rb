module VersioningGrape
  module V2
    class API < ::Grape::API
      version ['v2','v1'], using: :path, vendor: 'versioning-grape', cascade: true
      format :json
      # mount BaseAPI

      resource :test_v2 do
        desc 'test api v2'
        get do
          {status: "ok", version: "v2"}
        end
      end
    end
  end
end
