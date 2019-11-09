FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    question { nil }

    trait :invalid do
      body { nil }
    end

    trait :dynamic do
      sequence(:body) { |n| "Answer #{n}" }
    end
  end
end
