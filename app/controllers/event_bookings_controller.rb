class EventBookingsController < BaseController
    load_and_authorize_resource
  
    def index
      @event_bookings = EventBooking.all
      render json: @event_bookings
    end
  
    def show
      @event_booking = EventBooking.find(params[:id])
      render json: @event_booking
    end
  
    def create
      @event_booking = EventBooking.new(event_booking_params)
  
      if @event_booking.save
        @event_booking.payments.create(
          total_amount: @event_booking.total_price,
          payment_status: "in_process",
          payment_date: Time.current
        )
  
        @id_proof_url = @event_booking.id_proof.attached? ? url_for(@event_booking.id_proof) : nil
  
        render json: {
          message: "Event booking created successfully",
          event_booking: @event_booking.as_json(include: :payments),
          id_proof_url: @id_proof_url
        }, status: :created
      else
        render json: { error: @event_booking.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def event_booking_params
      params.require(:event_booking).permit(:user_id, :event_id, :number_of_tickets, :total_price, :id_proof)
    end
  end
  