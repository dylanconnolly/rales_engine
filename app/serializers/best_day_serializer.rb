class BestDaySerializer
  include FastJsonapi::ObjectSerializer

  attribute :best_day do |item|  
    item.best_day.strftime('%Y-%m-%d')
  end
end
