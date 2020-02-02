class InvoiceSerializer
    include FastJsonapi::ObjectSerializer

    belongs_to :merchant
    belongs_to :customer
    has_many :invoice_items

    attributes :id, :status, :merchant_id, :customer_id
end
