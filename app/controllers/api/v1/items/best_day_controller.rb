class Api::V1::Items::BestDayController < ApplicationController

  def index
    best_day = Item.best_day(params[:item_id])
    
    best_day_without_array = best_day[0]
    render json: BestDaySerializer.new(best_day_without_array)
  end
end
