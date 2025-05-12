# frozen_string_literal: true

class AddIndexOnVenueEventType < ActiveRecord::Migration[8.0]
  add_index :events, %i[venue_id event_type_id]
  def change; end
end
