module VersioningGrape
  module V1
    module Users
      class Registration < Grape::API
        namespace :users do
          params do
            requires :email, type: String
            requires :password, type: String
          end

          desc 'user registration'
          post :registration do
            declared_params = declared(params)
            service = UserServices::Register.new(declared_params)
            service.call

            if service.success?
              {
                success: true,
                data: {
                  message: 'Registration successfully.'
                }
              }
            else
              error!(
                {
                       errors: {
                         message: service.errors.values.flatten.join('\n')
                       }
                     }, 422)
            end
          end
        end
      end
    end
  end
end
