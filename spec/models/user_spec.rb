require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many :questions }
  it { should have_many :answers }

  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: author) }

  it 'check author of resource' do
    expect(author.author_of?(question)).to be_truthy
    expect(user.author_of?(question)).to be_falsey
  end
end
