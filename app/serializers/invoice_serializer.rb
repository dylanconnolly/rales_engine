class InvoiceSerializer
    include FastJsonapi::ObjectSerializer

    belongs_to :merchant
    belongs_to :customer

    attributes :id, :status, :merchant_id, :customer_id
end
