class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.where(email:params[:user][:email]).first || User.where(username:params[:user][:username]).first
        if @user.present?
            render json: {
                :errors => {
                    msg: "User is already registered with this email, Please try login",
                    status: 400
                }
            },status: 400
        else
            @user = User.new(reg_params)
            UserMailer.signup_confirmation(@user).deliver
            if @user.save
                render json: {
                    :user =>{
                        email: @user.email,
                        token: @user.authentication_token,
                        msg: "Registration Successful",
                        status: 200
                    }
                  }, status: 200
            else
                render json: {
                    :errors =>{
                        msg: "Something went wrong",
                        status: 400
                    }
                  }, status: 400

            end
            
        end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def reg_params
    params.require(:user).permit(:username,:email,:password)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
