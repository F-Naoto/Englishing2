require 'rails_helper'

RSpec.describe "StRelationships", type: :request do
  let!(:student) { create(:student) }
  let!(:teacher) { create(:teacher) }
  before do
    sign_in student
  end

  describe 'POST /st_relationships' do
    it '生徒が先生へのフォローに成功' do
      post st_relationships_path, params:{ followed_id: teacher.id}, xhr: true
      expect(response).to render_template "st_relationships/create"
    end
    it 'StRelationShipが1件保存される' do
      expect do
        post st_relationships_path, params:{ followed_id: teacher.id}, xhr: true
      end.to change(StRelationship, :count).by(1)
    end
  end

  describe 'DELETE /st_relationships/:id' do
    let!(:st_relationship) { create(:st_relationship, follower_id: student.id, followed_id: teacher.id) }

    it '生徒が先生へのアンフォローに成功' do
      delete st_relationship_path(st_relationship), params:{ followed_id: teacher.id }, xhr: true
      expect(response).to render_template  "st_relationships/destroy"
    end
    it 'StRelationShipが1件削除される' do
      expect do
        delete st_relationship_path(st_relationship), params:{ followed_id: teacher.id }, xhr: true
      end.to change(StRelationship, :count).by(-1)
    end
  end
end
