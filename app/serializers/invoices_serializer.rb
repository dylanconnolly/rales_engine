class InvoicesSerializer
    include FastJsonapi::ObjectSerializer

    belongs_to :merchant
    belongs_to :customer

    attributes :status
end
