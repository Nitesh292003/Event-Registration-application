# frozen_string_literal: true

class VenuesController < BaseController
  # before_action :set_venue, only: [:show, :update, :destroy]

  skip_before_action :authenticate_request, only: [:index]
  load_and_authorize_resource

  def index
    @venues = Venue.all
    render json: @venues
  end

  def show
    @venue = Venue.find(params[:id])
    render json: @venue
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      render json: @venue, status: :created
    else
      render json: { errors: @venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @venue.update(venue_params)
      render json: @venue
    else
      render json: { errors: @venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @venue.destroy
      render json: { message: 'Venue deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete venue' }, status: :unprocessable_entity
    end
  end

  # def set_venue
  #   @venue = Venue.find(params[:id])
  # end

  def venue_params
    params.require(:venue).permit(:venue_name, :address, :state, :country, :postal_code)
  end
end
