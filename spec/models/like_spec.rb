# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:student) { create(:student) }
  let!(:question) { create(:question) }

  describe 'いいね' do
    context '正常な場合' do
      it 'いいねの作成に成功' do
        like = create(:like)
        expect(like).to be_valid
        expect { create(:like) }.to change { Like.count }.by(1)
      end
      context 'いいねを取り消した場合' do
        it 'Likeモデルの件数が1件減る' do
          like = create(:like)
          expect { like.destroy }.to change { Like.count }.by(-1)
        end
      end
    end
  end
end
