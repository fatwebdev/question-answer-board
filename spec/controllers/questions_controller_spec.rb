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
    let(:params) { {} }

    subject { patch :update, params: { id: question, question: params } }

    context 'with valid attributes' do
      let(:params) { { title: 'new title', body: 'new body' } }

      it 'changes question attributes' do
        subject
        question.reload

        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        expect(subject).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      let(:params) { attributes_for(:question, :invalid) }

      it 'does not change question attributes' do
        expect do
          subject
          question.reload
        end.to not_change(question, :title)
          .and not_change(question, :body)
      end

      it 're-renders edit view' do
        expect(subject).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user2) { create(:user) }
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

    context 'user tries to remove not its question' do
      before { login(user2) }

      it 'delete the question' do
        expect do
          delete :destroy, params: { id: question }
        end.to_not change(Question, :count)
      end
    end
  end
end
