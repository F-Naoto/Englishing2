# frozen_string_literal: true

require 'rails_helper'
require 'devise'

RSpec.describe 'Rankings', type: :system do
  let!(:student) { create(:student, name: 'student', self_introduction: 'introduction') }
  let!(:teacher) { create(:teacher) }

  describe 'ページ遷移確認' do
    context '先生ランキングページに遷移' do
      it '先生ランキングページへのアクセスに成功' do
        visit teacher_reviews_ranking_path
        expect(page).to have_content 'Teacher Ranking'
        expect(page).to have_content teacher.name
      end
    end
    # context '先生の詳細ページに遷移' do
    #   it '先生の詳細ページへのアクセスに成功' do
    #     visit teacher_reviews_ranking_path
    #     expect(page).to have_link teacher.name
    #     find('.teacher').click
    #     expect(current_path).to eq teacher_path(teacher.id)
    #   end
    # end
  end

  describe '先生の表示確認' do
    context '先生の登録数が6件の場合' do
      it '6番目は表示されない' do
        teacher_list = create_list(:teacher, 5)
        visit teacher_reviews_ranking_path
        teacher_list[0..3].each do |teacher|
          expect(page).to have_content teacher.name
        end
        expect(page).to have_no_content teacher_list[4].name
      end
    end
  end
end
