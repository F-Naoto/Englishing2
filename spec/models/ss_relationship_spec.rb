# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SsRelationship, type: :model do
  let!(:student) { create(:student) }
  let!(:other_student) { create(:student) }
  before { student.ss_follow(other_student.id) }

  describe '生徒が生徒をフォロー' do
    context '情報が正常な場合' do
      it '生徒が先生のフォローに成功する' do
        expect(student.ss_following?(other_student)).to be_truthy
      end
    end
  end
  describe '生徒が生徒をアンフォロー' do
    context '情報が正常な場合' do
      it '生徒が生徒のアンフォローに成功する' do
        unfollow = student.ss_unfollow(other_student.id)
        expect { unfollow.delete }.to change { SsRelationship.count }.by(-1)
      end
    end
  end
end
