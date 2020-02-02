class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    Item.most_revenue(params[:quantity])
    require "pry"; binding.pry
  end
end
