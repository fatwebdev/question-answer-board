FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "Answer #{n}" }
    question { nil }

    trait :invalid do
      body { nil }
    end
  end
end
