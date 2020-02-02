class Api::V1::Items::RandomItemController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all.sample)
  end
end
