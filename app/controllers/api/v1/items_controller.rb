class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item
  end
end
