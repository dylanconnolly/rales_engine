class Transaction < ApplicationRecord
  belongs_to :invoice
  scope :successful, -> {where(result: "success")}

  enum result: ["success", "failed"]
end
