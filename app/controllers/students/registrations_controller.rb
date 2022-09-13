# frozen_string_literal: true

class Students::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only:[:create, :update]

  def update
    super
    if account_update_params[:avatar].present?
      resource.avatar.attach(account_update_params[:avatar])
    end
  end

  protected
  def after_update_path_for(resource)
    student_path(current_student)
  end

  def after_sign_up_path_for(resource)
    student_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :self_introduction, :avatar])
  end
end
