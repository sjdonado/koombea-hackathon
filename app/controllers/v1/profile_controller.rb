module V1
  class ProfileController < BaseController
    before_action :authenticate
  
    # GET /profile
    def show
      render json: @current_user
    end
  
    # PATCH/PUT /profile
    def update
      if @current_user.update(profile_params)
        render json: @current_user
      else
        render_error(:unprocessable_entity, nil, @current_user.errors)
      end
    end

    # PATCH/PUT /profile/photo
    def update_photo
      if @current_user.update(photo: params[:photo])
        render json: @current_user
      else
        render_error(:unprocessable_entity, nil, @current_user.errors)
      end
    end

    private
      # Only allow a trusted parameter "white list" through.
      def profile_params
        params.permit(:name, :email, :address, :phone)
      end
  end
end
