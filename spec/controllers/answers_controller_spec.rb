require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:author) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'POST #create' do
    let(:params) { { question_id: question, answer: attributes_for(:answer) } }
    subject { post :create, params: params }
    before { login(author) }

    context 'with valid attributes' do
      it 'saves a new question answer' do
        expect { subject }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show questions view' do
        expect(subject).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      let(:params) { { question_id: question, answer: attributes_for(:answer, :invalid) } }

      it 'does not save a new question answer' do
        expect { subject }.to_not change(Answer, :count)
      end

      it 're-renders show question view' do
        expect(subject).to render_template 'questions/show'
      end
    end

    context 'as not authenticated user' do
      before { sign_out(user) }

      it 'does not saves a new question answer' do
        expect { subject }.to_not change(Answer, :count)
      end

      it 'redirects to sign in' do
        expect(subject).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:params) { { body: 'new body' } }
    subject { patch :update, params: { id: answer, answer: params } }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        subject
        answer.reload

        expect(answer.body).to eq 'new body'
      end

      it 'redirects to updated answer' do
        expect(subject).to redirect_to answer
      end
    end

    context 'with invalid attributes' do
      let(:params) { attributes_for(:answer, :invalid) }

      it 'does not change answer attributes' do
        expect do
          subject
          answer.reload
        end.to_not change(answer, :body)
      end

      it 're-renders edit view' do
        expect(subject).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, user: author) }
    subject { delete :destroy, params: { id: answer } }

    context 'as author' do
      before { login(author) }

      it 'deletes the question answer' do
        expect { subject }.to change(question.answers, :count).by(-1)
      end

      it 'redirects to index' do
        expect(subject).to redirect_to question
      end
    end

    context 'as user' do
      before { login(user) }

      it 'does not delete the question answer' do
        expect { subject }.to_not change(Answer, :count)
      end

      it 'redirects to index' do
        expect(subject).to redirect_to question
      end
    end

    context 'as not authenticated user' do
      it 'does not delete the question answer' do
        expect { subject }.to_not change(Question, :count)
      end

      it 'redirects to sign in' do
        expect(subject).to redirect_to new_user_session_path
      end
    end
  end
end
