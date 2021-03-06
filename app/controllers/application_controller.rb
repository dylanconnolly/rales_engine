class ApplicationController < ActionController::API

  def converted_params
    converted_params = search_params.clone
    if search_params.keys.include?("unit_price")
      converted_params["unit_price"] = (search_params["unit_price"].to_f * 100).round()
    end
    if search_params.keys.include?("status")
      converted_params["status"] = (search_params["status"].downcase)
    end
    if search_params.keys.include?("name")
      converted_params["name"] = (search_params["name"].titleize)
    end
    if search_params.keys.include?("description")
      converted_params["description"] = capitalize_start_of_each_sentence(search_params["description"])
    end
    if search_params.keys.include?("result")
      converted_params["result"] = (search_params["result"].downcase)
    end
    if search_params.keys.include?("first_name")
      converted_params["first_name"] = (search_params["first_name"].titleize)
    end
    if search_params.keys.include?("last_name")
      converted_params["last_name"] = (search_params["last_name"].titleize)
    end
    converted_params
  end

  private

    def capitalize_start_of_each_sentence(description)
      description.split('. ').map do |sentence|
        sentence.capitalize
      end.join('. ')
    end
end
