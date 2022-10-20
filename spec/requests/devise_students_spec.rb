require 'rails_helper'

RSpec.describe "DeviseStudents", type: :request do
  let(:student) { create(:student) }
  let(:student_params) { attributes_for(:student) }
  let(:invalid_student_params) { attributes_for(:student, name: "") }

  describe 'GET /students' do
    it 'リクエストが成功する' do
      get students_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /students' do
    context 'パラメータが正常な場合' do
      it 'リクエストが成功する' do
        post student_registration_path, params: { student: student_params }
        expect(response.status).to eq 302
      end

      it 'createが成功する' do
        expect do
          post student_registration_path, params: { student: student_params }
        end.to change(Student, :count).by 1
      end

      it 'リダイレクトされる' do
        post student_registration_path, params: { student: student_params }
        expect(response).to redirect_to student_path(Student.last)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが失敗する' do
        post student_registration_path, params: { student: invalid_student_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗する' do
        expect do
          post student_registration_path, params: { student: invalid_student_params }
        end.to_not change(Student, :count)
      end

      it 'エラーが表示される' do
        post student_registration_path, params: { student: invalid_student_params }
        expect(response.body).to include '※名前を入力してください'
      end
    end
  end

  describe 'GET /students/edit' do
    subject { get edit_student_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in student
      end
      it 'リクエストが成功する' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされる' do
        is_expected.to redirect_to new_student_session_path
      end
    end
  end

  describe 'GET /students/:id' do
    it 'リクエストが成功する' do
      get student_path(student)
      expect(response).to have_http_status(200)
    end
    context 'ユーザーが存在しない場合' do
      it 'エラーが発生する' do
        student.delete
        expect{ get student_path(student) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
