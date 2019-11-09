FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }

    trait :invalid do
      title { nil }
    end

    trait :dynamic do
      sequence(:title) { |n| "Question #{n} title" }
      sequence(:body) { |n| "Question #{n} body" }
    end
  end
end
