module V1
  class UsersController < BaseController
    before_action :authenticate, except: %i[sign_up sign_in]
    # before_action(only: %i[index]) { auth(%i[admin production storer]) }
    # before_action :set_user, only: %i[sign_out]

    # GET /users
    # def index
    #   @users = User.all

    #   render json: @users
    # end

    # POST /users/sign_in
    def sign_in
      @user = User.find_by(email: user_params[:email])

      raise ApiError.new(:bad_request, nil, ApiError.errors[2]) if @user.nil?

      token = JsonWebToken.encode(user_id: @user.id)
      user_response = UserSerializer.new(@user).as_json
      user_response[:api_key] = token

      render json: user_response, status: :ok
    end

    # POST /users/sign_up
    def sign_up
      if user_params[:password] != user_params[:password_confirmation]
        raise ApiError.new(:bad_request, nil, ApiError.errors[0])
      end

      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        render_error(:unprocessable_entity, nil, @user.errors)
      end
    end

    # POST /users/sign_out
    def sign_out
      if @current_user.update(last_token: @current_token)
        render json: {}
      else
        render_error(:unprocessable_entity, nil, @current_user.errors)
      end
    end

    # # DELETE /users/1
    # def destroy
    #   @user.destroy
    # end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(
        :name, :email, :address, :phone, :password, :password_confirmation
      )
    end
  end
end
