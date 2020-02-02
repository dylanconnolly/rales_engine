class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :invoice

  attributes :id, :credit_card_number, :result, :invoice_id
end
