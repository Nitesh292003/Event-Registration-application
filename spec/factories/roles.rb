# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:role_type) { |n| %w[admin user organizer][n % 3] }

    # role_type { %w[admin user organizer].sample }  # Randomly selects one of the 3 roles (admin, user, organizer)

  end
end
