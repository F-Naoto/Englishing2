# frozen_string_literal: true

module Students
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, only: %i[create update]
    before_action :ensure_normal_user, only: %i[destroy]

    def create
      if Teacher.find_by(email: sign_up_params[:email])
        redirect_to root_url
        flash[:alert] = "先生と同じメールアドレスは使用できません。"
      else
        super
      end
    end

    def update
      super
      resource.avatar.attach(account_update_params[:avatar]) if account_update_params[:avatar].present?
    end

    protected

    def after_update_path_for(_resource)
      student_path(current_student)
    end

    def after_sign_up_path_for(resource)
      student_path(resource)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[email name self_introduction avatar])
    end

    before_action :ensure_normal_user, only: :destroy

    def ensure_normal_user
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。' if resource.email == 'guest_student@example.com'
    end
  end
end
