module UserServices
  class Register
    attr_reader :errors

    def initialize(params)
      @params = params
      @errors = {}
    end

    def user_params
      @params.merge({ password: @params[:password] })
    end

    def user
      @user ||= User.new(user_params)
    end

    def create_user
      @user.save
    end

    def validate_params
      @errors.merge!(@user.errors.as_json(full_messages: true)) unless user.valid?
    end

    def success?
      @errors.empty?
    end

    def call
      validate_params
      return self unless @errors.empty?

      create_user

      self
    end
  end
end
