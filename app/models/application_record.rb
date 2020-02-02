class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def convert_to_dollars(unit_price)
    unit_price/100.0
  end
end
