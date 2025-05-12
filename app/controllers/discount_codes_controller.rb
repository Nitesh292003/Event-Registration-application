# frozen_string_literal: true

class DiscountCodesController < BaseController
  load_and_authorize_resource

  before_action :set_discount_code, only: %i[show update destroy]

  def discount_codes_by_event
    @discount_codes = DiscountCode.where(event_id: params[:event_id])

    if @discount_codes.present?
      render json: @discount_codes
    else
      render json: { message: 'No discount codes found for this event' }, status: :not_found
    end
  end

  def discount_codes_by_user
    @discount_codes = DiscountCode.where(user_id: params[:user_id])

    if @discount_codes.present?
      render json: @discount_codes
    else
      render json: { message: 'No discount codes found for this user' }, status: :not_found
    end
  end

  def index
    @discount_codes = DiscountCode.all
    render json: @discount_codes
  end

  def create
    @discount_code = DiscountCode.new(discount_code_params)

    if @discount_code.save
      render json: @discount_code, status: :created
    else
      render json: { errors: @discount_code.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @discount_code.update(discount_code_params)
      render json: @discount_code
    else
      render json: { errors: @discount_code.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @discount_code.destroy
      render json: { message: 'Discount code deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete discount code' }, status: :unprocessable_entity
    end
  end

  def show
    render json: @discount_code
  end

  def apply
    # Implement discount application logic here
  end

  private

  def discount_code_params
    params.require(:discount_code).permit(
      :code,
      :discount_percentage,
      :start_date,
      :end_date,
      :event_id,
      :user_id,
      :status,
      :max_uses
    )
  end

  def set_discount_code
    @discount_code = DiscountCode.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Discount code not found' }, status: :not_found
  end
end
