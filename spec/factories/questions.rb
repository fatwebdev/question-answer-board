FactoryBot.define do
  sequence(:title) { |n| "Question #{n} title" }
  sequence(:body) { |n| "Body #{n}" }

  factory :question do
    title { 'MyString' }
    body { 'MyText' }

    trait :invalid do
      title { nil }
    end

    trait :dynamic do
      title
      body
    end
  end
end
