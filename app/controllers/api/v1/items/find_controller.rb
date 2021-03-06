class Api::V1::Items::FindController < ApplicationController

  def index
    item = Item.order(:id).find_by(converted_params)

    render json: ItemSerializer.new(item)
  end

  private

    def search_params
      params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
    end

end
