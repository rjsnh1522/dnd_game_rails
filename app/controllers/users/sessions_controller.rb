class Users::SessionsController < Devise::SessionsController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    
  # before_action :configure_sign_in_params, only: [:create]
    before_action :restrict_access, except:[:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # super
    # binding.pry
    @user = User.where(email:params[:credentials][:email]).first
    if @user&.valid_password?(params[:credentials][:password])
        render json: {
            :user => {
                email: @user.email,
                token: @user.authentication_token
            }
        },status: :created
    else
        # head(:unauthorized)
        render json: {
            :errors =>{
                msg: "No such user; check the submitted email address",
                status: 400
            }
          }, status: 400
    end
  end


  def current_logged_in_user
    # @user_data = restrict_access
      if @current_user.present?
        render json: {
          :user => {
              email: @user.email,
              username:@user.username,
              token: @user.authentication_token
          }
      },status: 200
      else
        render json: {
          :errors =>{
              msg: "No such user; check the submitted email address",
              status: 400
          }
        }, status: 400
      end
  end


  def restrict_access
    authenticate_or_request_with_http_token do |token ,options|
       @user = User.find_by_authentication_token(token)
       @current_user = @user if @user.present?
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
