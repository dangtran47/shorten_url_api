module UserServices
  class SignIn
    attr_reader :errors, :params

    def initialize(params)
      @params = params
      @errors = {}
      @user = nil
    end

    def user_params
      @params
    end

    def find_user
      @user ||= User.find_by_email(params[:email])
    end

    def validate
      return if @user && @user.match_password?(params[:password])

      @errors.merge!({ 'email or password' => 'Email or password is invalid.' })
    end

    def generate_jwt
      @user.generate_jwt.to_json
    end

    def success?
      @errors.empty?
    end

    def call
      find_user
      validate
      self
    end
  end
end
