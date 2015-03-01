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
end
