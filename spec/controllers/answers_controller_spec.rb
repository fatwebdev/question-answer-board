require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new question answer in the database' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer) }
        end.to change(question.answers, :count).by(1)
      end

      it 'redirects to show questions view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }

        expect(response).to redirect_to controller.answer.question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the questions answer' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        end.to_not change(question.answers, :count)
      end

      it 're-render show question view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }

        expect(response).to render_template 'questions/show'
      end
    end

    context 'unathenticate user' do
      before { sign_out(user) }

      it 'try saves a new answer in the database' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer) }
        end.to_not change(question.answers, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' }}
        answer.reload

        expect(answer.body).to eq 'new body'
      end

      it 'redirects to updated answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }

        expect(response).to redirect_to answer
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid)} }
      it 'does not change answer attributes' do
        answer.reload

        expect(answer.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user2) {create(:user) }
    let!(:answer) { create(:answer, question: question, user: user) }

    it 'delete the question answer' do
      expect do
        delete :destroy, params: { id: answer }
      end.to change(question.answers, :count).by(-1)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: answer }

      expect(response).to redirect_to question
    end

    context 'user tries to remove not its answer' do
      before { login(user2) }

      it 'delete the answer' do
        expect do
          delete :destroy, params: { id: answer }
        end.to_not change(Answer, :count)
      end
    end
  end
end
