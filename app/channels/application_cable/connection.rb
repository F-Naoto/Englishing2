module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_student

    def connect
      # reject_unauthorized_connection unless find_verified_student
    end

    private

    def find_verified_student
      # self.current_student = env['warden'].student
    end
  end
end
