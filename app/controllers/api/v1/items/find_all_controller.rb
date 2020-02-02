class Api::V1::Items::FindAllController < ApplicationController

  def index
    items = Item.where(converted_params)

    render json: ItemSerializer.new(items)
  end

  private

    def search_params
      params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
    end
end
