# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StRelationship, type: :model do
  let!(:student) { create(:student) }
  let!(:teacher) { create(:teacher) }
  before { student.st_follow(teacher.id) }

  describe '生徒が先生をフォロー' do
    context '正常な場合' do
      it '生徒が生徒のアンフォローに成功する' do
        expect(student.st_following?(teacher)).to be_truthy
      end
    end
  end
  describe '生徒が先生をアンフォロー' do
    context '正常な場合' do
      it '生徒が生徒のアンフォローに成功する' do
        unfollow = student.st_unfollow(teacher.id)
        expect { unfollow.delete }.to change { StRelationship.count }.by(-1)
      end
    end
  end
end
