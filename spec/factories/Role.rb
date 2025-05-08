FactoryBot.define do
    factory :role do
      sequence(:role_type) { |n| ["admin", "user", "organizer"][n % 3] }
    end
  end
  
  
  
  

      