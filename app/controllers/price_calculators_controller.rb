# frozen_string_literal: true

class PriceCalculatorsController < ApplicationController
  def total_price
    max_number_of_tickets = 4
    number_of_tickets = params[:number_of_tickets].to_i
    event = Event.find_by(id: params[:event_id])

    if event.nil?
      render json: { error: 'Event not found' }, status: :not_found
      return
    end

    if number_of_tickets > max_number_of_tickets
      render json: {
        error: "Number of tickets exceeds the maximum limit of #{max_number_of_tickets}."
      }, status: :unprocessable_entity
      return
    end

    available_seats = event.capacity - event.registered_count
    if available_seats < number_of_tickets
      render json: {
        error: "Not enough seats available. Only #{available_seats} seats left."
      }, status: :unprocessable_entity
      return
    end

    base_price = event.base_price
    total_price = base_price * number_of_tickets

    render json: {
      total_price: total_price,
      available_seats: available_seats
    }
  end

  def early_bird_discount
    event = Event.find_by(id: params[:event_id])
    total_price = params[:total_price].to_f

    if event&.early_bird_end_time.present? && Time.current < event.early_bird_end_time
      discounted_price = (total_price * event.early_bird_price) / 100
      render json: { total_price: discounted_price }
    else
      render json: { error: 'You are not eligible for Early Bird Discount' }, status: :forbidden
    end
  end

  def apply_discount
    discount_code = DiscountCode.find_by(code: params[:code])
    total_price = params[:total_price].to_f

    if discount_code.nil? ||
       discount_code.status != 'active' ||
       discount_code.used_count >= discount_code.max_uses ||
       Time.current < discount_code.start_date ||
       Time.current > discount_code.end_date

      render json: { error: 'Discount code is not valid or expired' }, status: :forbidden
      return
    end

    discounted_price = (total_price * (100 - discount_code.discount_percentage)) / 100.0
    discount_code.increment!(:used_count)

    render json: {
      total_price: discounted_price
    }
  end
end
