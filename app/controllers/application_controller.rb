class ApplicationController < ActionController::API

  def converted_params
    converted_params = search_params.clone
    if search_params.keys.include?("unit_price")
      converted_params["unit_price"] = (search_params["unit_price"].to_f * 100).ceil
    end
    converted_params
  end
end
