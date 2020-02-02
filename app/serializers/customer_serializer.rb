class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  has_many :invoices

  attributes :id, :first_name, :last_name

end
