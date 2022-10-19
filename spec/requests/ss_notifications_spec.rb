require 'rails_helper'

RSpec.describe 'SsNotifications', type: :request do
  let(:student) { create(:student)  }

  describe 'GET /index' do
    it 'description' do
      sign_in student
      get ss_notifications_path
      expect(response).to have_http_status(200)
    end
  end
end
