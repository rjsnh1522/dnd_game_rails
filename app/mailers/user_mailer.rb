class UserMailer < ApplicationMailer
  
      default from: "pawan@yopmail.com"
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.user_mailer.signup_confirmation.subject
    #
    def signup_confirmation(user)
      @user = user
  
      mail to: @user.email , subject: "Email Confirmation"
    end
  end
  