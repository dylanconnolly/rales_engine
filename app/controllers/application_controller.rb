class ApplicationController < ActionController::API

  def converted_params
    converted_params = search_params.clone
    if search_params.keys.include?("unit_price")
      converted_params["unit_price"] = (search_params["unit_price"].to_f * 100).round()
    end
    if search_params.keys.include?("status")
      converted_params["status"] = (search_params["status"].downcase)
    end
    converted_params
  end
end
