# frozen_string_literal: true

module Students
  class SessionsController < Devise::SessionsController
    before_action :check_both_login
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
    def guest_sign_in
      student = Student.guest
      sign_in student
      redirect_to root_path, notice: 'GuestStudentとしてログインしました。'
    end

    def after_sign_in_path_for(resource)
      student_path(resource)
    end

    def check_both_login
      if current_teacher
        redirect_to root_url
        flash[:alert] = '先生と生徒は同時にログインできません。先生アカウントをログアウトしてください。'
      end
    end
  end
end
