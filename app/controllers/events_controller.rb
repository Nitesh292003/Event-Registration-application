# frozen_string_literal: true

class EventsController < BaseController
  load_and_authorize_resource

  before_action :set_event, only: %i[update destroy show]

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index_by_user
    @events = Event.where(user_id: params[:user_id])

    if @events.any?
      render json: @events, status: :ok
    else
      render json: { error: 'No events found for this user' }, status: :not_found
    end
  end

  def index
    @events = Event.all
    render json: @events
  end

  def show
    render json: @event
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      render json: { message: 'Event deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete event' }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :organizer_name,
      :event_name,
      :description,
      :event_date,
      :event_end_date,
      :start_time,
      :end_time,
      :capacity,
      :base_price,
      :early_bird_price,
      :early_bird_end_time,
      :status,
      :user_id,
      :event_type_id,
      :venue_id
    )
  end

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Event not found' }, status: :not_found
  end
end
