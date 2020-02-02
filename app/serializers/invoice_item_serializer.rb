class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :item
  belongs_to :invoice

  attributes :id, :quantity, :item_id, :invoice_id

  attribute :unit_price do |invoice_item|
    '%.2f' % invoice_item.item.convert_to_dollars(invoice_item.item.unit_price)
  end

end
