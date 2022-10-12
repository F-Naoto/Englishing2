require 'rails_helper'

RSpec.describe StRelationship, type: :model do
  let(:student) { create(:student) }
  let(:teacher) { create(:teacher) }
  before { student.st_follow(teacher.id) }

  describe "follow" do
    it "フォローできる" do
      expect(student.st_following?(teacher)).to be_truthy
    end
  end
  describe "unfollow" do
    it "アンフォローできる" do
      unfollow = student.st_unfollow(teacher.id)
      expect{ unfollow.delete }.to change{ StRelationship.count }.by(-1)
    end
  end
end
