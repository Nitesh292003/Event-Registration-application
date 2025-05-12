# frozen_string_literal: true

class DiscountCodeTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :discount_code
end
