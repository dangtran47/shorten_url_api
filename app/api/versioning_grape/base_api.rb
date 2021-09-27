module VersioningGrape
  class BaseAPI < ::Grape::API
    resource :test do
      desc 'testing api.'
      get 'test' do
        {status: "ok"}
      end
    end
  end
end
