require 'rails_helper'

RSpec.describe SsRelationship, type: :model do
  let(:student) { create(:student) }
  let(:other_student) { create(:student) }
  before { student.ss_follow(other_student.id) }

  describe "follow" do
    it "フォローできる" do
      expect(student.ss_following?(other_student)).to be_truthy
    end
  end
  describe "unfollow" do
    it "アンフォローできる" do
      unfollow = student.ss_unfollow(other_student.id)
      expect{ unfollow.delete }.to change{ SsRelationship.count }.by(-1)
    end
  end
end
