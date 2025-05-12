# frozen_string_literal: true

class PaymentsController < ApplicationController
  def payment_success_url
    return unless params[:payment_status] == 'success'

    if params[:event_booking_id].present?
      @event_booking = EventBooking.find(params[:event_booking_id])
      @event_booking.update(status: 'confirmed')
      @payment = Payment.find_by(event_booking_id: params[:event_booking_id])
      @payment.update(payment_status: 'success', payment_date: Time.current)
      @number_of_tickets = @event_booking.number_of_tickets
      @event = Event.find(@event_booking.event_id)
      @event.update(registered_count: @event.registered_count + @number_of_tickets)
      render json: { message: 'Payment successful', event_booking: @event_booking.as_json(include: :payments) },
             status: :ok
    else
      render json: { error: 'Event booking not found' }, status: :not_found
    end
  end

  def payment_failure_url
    return unless params[:payment_status] == 'failure'

    if params[:event_booking_id].present?
      @event_booking = EventBooking.find(params[:event_booking_id])
      @event_booking.update(status: 'failed')
      @payment = Payment.find_by(event_booking_id: params[:event_booking_id])
      @payment.update(payment_status: 'failure', payment_date: Time.current)
      render json: { message: 'Payment failed', event_booking: @event_booking.as_json(include: :payments) },
             status: :ok
    else
      render json: { error: 'Event booking not found' }, status: :not_found
    end
  end
end
