# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeviseTeachers', type: :request do
  let(:teacher) { create(:teacher) }
  let(:teacher_params) { attributes_for(:teacher) }
  let(:invalid_teacher_params) { attributes_for(:teacher, name: '') }

  describe 'GET /teachers' do
    it 'リクエストが成功する' do
      get teachers_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /teachers' do
    context 'パラメータが正常な場合' do
      it 'リクエストが成功する' do
        post teacher_registration_path, params: { teacher: teacher_params }
        expect(response.status).to eq 302
      end

      it 'createが成功する' do
        expect do
          post teacher_registration_path, params: { teacher: teacher_params }
        end.to change(Teacher, :count).by 1
      end

      it 'リダイレクトされる' do
        post teacher_registration_path, params: { teacher: teacher_params }
        expect(response).to redirect_to teacher_path(Teacher.last)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが失敗する' do
        post teacher_registration_path, params: { teacher: invalid_teacher_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗する' do
        expect do
          post teacher_registration_path, params: { teacher: invalid_teacher_params }
        end.to_not change(Teacher, :count)
      end

      it 'エラーが表示される' do
        post teacher_registration_path, params: { teacher: invalid_teacher_params }
        expect(response.body).to include '※名前を入力してください'
      end
    end
  end

  describe 'GET /teachers/edit' do
    subject { get edit_teacher_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in teacher
      end
      it 'リクエストが成功する' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされる' do
        is_expected.to redirect_to new_teacher_session_path
      end
    end
  end

  describe 'GET /teachers/:id' do
    it 'リクエストが成功する' do
      get teacher_path(teacher)
      expect(response).to have_http_status(200)
    end
    context 'ユーザーが存在しない場合' do
      it 'エラーが発生する' do
        teacher.delete
        expect { get teacher_path(teacher) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
