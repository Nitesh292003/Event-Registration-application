# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:phone_no) { |n| n.to_s.rjust(10, '1') }
    sequence(:password) { |n| "securePass#{n}" }
    association :role, factory: :role
  end
end
