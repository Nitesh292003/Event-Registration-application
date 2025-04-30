class EventTypesController < BaseController
  before_action :set_event_type, only: %i[update destroy]
  load_and_authorize_resource

  def index
    @event_types = EventType.all
    render json: @event_types
  end

  def create
    @event_type = EventType.new(event_type_params)
    if @event_type.save
      render json: { message: 'Event type was successfully created.' }, status: :created
    else
      render json: { errors: @event_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @event_type.update(event_type_params)
      render json: { message: 'Event type was successfully updated.' }, status: :ok
    else
      render json: { errors: @event_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @event_type.destroy
      render json: { message: 'Event type was successfully deleted.' }, status: :ok
    else
      render json: { error: 'Failed to delete event type' }, status: :unprocessable_entity
    end
  end

  private

  def set_event_type
    @event_type = EventType.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Event type not found' }, status: :not_found
  end

  def event_type_params
    params.require(:event_type).permit(:event_type_name)
  end
end
