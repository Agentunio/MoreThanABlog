# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  skip_before_action :verify_authenticity_token
  respond_to :json
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)

    if resource.save
      render json: {
        message: 'Rejestracja pomyślna. Zaloguj się, aby kontynuować.',
        user: resource
      }, status: :created
    else
      render json: {
        errors: resource.errors.full_messages,
        message: 'Rejestracja nie powiodła się.'
      }, status: :unprocessable_entity
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
    if resource.update_with_password(account_update_params)
      bypass_sign_in(resource, scope: :user)
      render json: {
        status: { code: 200, message: 'Konto zaktualizowane pomyślnie.' },
        data: resource
      }
    else
      render json: {
        status: {
          code: 422,
          message: "Błąd podczas aktualizacji konta.",
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

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

  private

  def account_update_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password)
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
