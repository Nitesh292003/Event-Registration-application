# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users
  validates :role_type, presence: { message: "Role type should not be empty" }

end
