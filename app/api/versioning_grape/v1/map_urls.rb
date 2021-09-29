module VersioningGrape
  module V1
    class MapUrls < ::Grape::API
      resource :map_urls do
        desc 'map urls v1'
        get do
          { status: "ok", version: "v2" }
        end
      end
    end
  end
end
