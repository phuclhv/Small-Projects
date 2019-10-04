class Payment < ApplicationRecord
  belongs_to  :school_user
  belongs_to  :payment_type
end
