require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }

        expect(response).to redirect_to controller.question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create, params: { question: attributes_for(:question, :invalid) }
        end.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }

        expect(response).to render_template :new
      end
    end

    context 'unauthenticate user' do
      before { sign_out(user) }

      it 'try saves a new question in the database' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end.to_not change(Question, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }}
        question.reload

        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        patch :update, params: { id: question, question: attributes_for(:question) }

        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: attributes_for(:question, :invalid)} }
      it 'does not change question attributes' do
        question.reload

        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: user) }

    it 'delete the question' do
      expect do
        delete :destroy, params: { id: question }
      end.to change(Question, :count).by(-1)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: question }

      expect(response).to redirect_to questions_path
    end
  end
end
