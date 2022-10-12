require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:student) { create(:student) }
  let(:question) { create(:question) }

  it "正常にいいねできる" do
    like = create(:like)
    expect(like).to be_valid
  end

  it "いいねするとLikeモデルの件数が1件増える" do
    expect{ create(:like) }.to change{ Like.count }.by(1)
  end

  it "いいねを取り消すとLikeモデルの件数が1件減る" do
    like = create(:like)
    expect{ like.destroy }.to change{ Like.count }.by(-1)
  end
end
