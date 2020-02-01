class Api::V1::Items::FindController < ApplicationController

  def index
    item = Item.order(:id).find_by(converted_params)
    
    render json: ItemSerializer.new(item)
  end

  private

    def search_params
      params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at)
    end

    def converted_params
      converted_params = search_params.clone
      if search_params.keys.include?("unit_price")
        converted_params["unit_price"] = (search_params["unit_price"].to_f * 100).to_i
      end
      converted_params
    end

end
