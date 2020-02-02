class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |item|
    '%.2f' % item.convert_to_dollars(item.unit_price)
  end

  belongs_to :merchant
end
