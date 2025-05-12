# spec/factories/discount_codes.rb
FactoryBot.define do
  factory :discount_code do
    sequence(:code) { |n| "DISCOUNT#{n}" }
    discount_percentage { Faker::Number.between(from: 5, to: 50) }
    start_date { 2.days.from_now }
    end_date { 10.days.from_now }
    max_uses { 100 }
    used_count { 0 }
    status { "active" }
  
    association :event
    user { event.user }  
  end
end
  