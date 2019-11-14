require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many :questions }
  it { should have_many :answers }

  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: author) }

  context 'check author of resource' do
    it 'as an author' do
      expect(author).to be_author_of(question)
    end

    it 'as not an author' do
      expect(user).to_not be_author_of(question)
    end
  end
end
