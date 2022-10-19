require 'rails_helper'

RSpec.describe 'SsRelationships', type: :request do
  let!(:student) { create(:student) }
  let!(:other_student) { create(:student) }
  before do
    sign_in student
  end

  describe 'POST /ss_relationships' do
    it '生徒が他の生徒のフォローに成功' do
      post ss_relationships_path, params:{ followed_id: other_student.id}, xhr: true
      expect(response).to render_template "ss_relationships/create"
    end
    it 'SsRelationShipが1件保存される' do
      expect do
        post ss_relationships_path, params:{ followed_id: other_student.id}, xhr: true
      end.to change(SsRelationship, :count).by(1)
    end
    it 'SsNotificationが1件保存される' do
      expect do
        post ss_relationships_path, params:{ followed_id: other_student.id}, xhr: true
      end.to change(SsNotification, :count).by(1)
    end
  end

  describe 'DELETE /ss_relationships/:id' do
    let!(:ss_relationship) { create(:ss_relationship, follower_id: student.id, followed_id: other_student.id) }

    it '生徒が他の生徒のアンフォローに成功' do
      delete ss_relationship_path(ss_relationship), params:{ followed_id: other_student.id }, xhr: true
      expect(response).to render_template  "ss_relationships/destroy"
    end
    it 'SsRelationShipが1件削除される' do
      expect do
        delete ss_relationship_path(ss_relationship), params:{ followed_id: other_student.id }, xhr: true
      end.to change(SsRelationship, :count).by(-1)
    end
  end
end
