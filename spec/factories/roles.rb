# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:role_type) { |n| %w[admin user organizer][n % 3] }
  end
end
