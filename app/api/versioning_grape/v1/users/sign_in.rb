module VersioningGrape
  module V1
    module Users
      class SignIn < Grape::API
        namespace :users do
          params do
            requires :email, type: String
            requires :password, type: String
          end

          desc 'user sign in'
          post :sign_in do
            declared_params = declared(params)
            service = UserServices::SignIn.new(declared_params)
            service.call

            if service.success?
              {
                success: true,
                data: service.generate_jwt
              }
            else
              error!(
                {
                  errors: {
                    message: service.errors.values.flatten.join('\n')
                  }
                }, 422
              )
            end
          end
        end
      end
    end
  end
end
