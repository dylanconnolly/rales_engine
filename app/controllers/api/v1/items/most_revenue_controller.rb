class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    most_revenue = Item.most_revenue(params[:quantity])
    
    render json: ItemSerializer.new(most_revenue)
  end
end
