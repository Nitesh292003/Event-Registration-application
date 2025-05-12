FactoryBot.define do
  factory :event do
    organizer_name { Faker::Name.name }
    sequence(:event_name) { |n| "Tech Conference #{n}" }
    description { Faker::Lorem.paragraph(sentence_count: 3) }

    start_time { 3.days.from_now.change(min: 0) }
    end_time { start_time + 2.hours }

    event_date { start_time } 
    event_end_date { event_date + 2.days }

    capacity { Faker::Number.between(from: 50, to: 500) }
    registered_count { 0 }

    base_price { Faker::Number.between(from: 20, to: 100) }
    early_bird_price { base_price - 10 }
    early_bird_end_time { event_date - 1.day }

    status { "upcoming" }

    association :user
    association :venue
    association :event_type
  end
end
