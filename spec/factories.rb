FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "Acme #{n}" }
  end

  factory :user do
    organization
    firstname "Jane"
    lastname  "Doe"
    sequence(:email_address) { |n| "user-#{n}@example.com" }
  end

  factory :kudo do
    message "hurrah for so and so"
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
