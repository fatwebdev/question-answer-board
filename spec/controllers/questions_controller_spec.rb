require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    let(:params) { { question: attributes_for(:question) } }
    subject { post :create, params: params }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { subject }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        expect(subject).to redirect_to controller.question
      end
    end

    context 'with invalid attributes' do
      let(:params) { { question: attributes_for(:question, :invalid) } }

      it 'does not save the question' do
        expect { subject }.to_not change(Question, :count)
      end

      it 're-render new view' do
        expect(subject).to render_template :new
      end
    end

    context 'unauthenticate user' do
      before { sign_out(user) }

      it 'try saves a new question in the database' do
        expect { subject }.to_not change(Question, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:params) { { id: question, question: { title: 'new title', body: 'new body' } } }
    subject { patch :update, params: params }

    context 'with valid attributes' do
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
      let(:params) { { id: question, question: attributes_for(:question, :invalid) } }

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

    subject { delete :destroy, params: { id: question } }

    it 'delete the question' do
      expect { subject }.to change(Question, :count).by(-1)
    end

    it 'redirect to index' do
      expect(subject).to redirect_to questions_path
    end

    context 'user tries to remove not its question' do
      before { login(user2) }

      it 'delete the question' do
        expect { subject }.to_not change(Question, :count)
      end
    end
  end
end
