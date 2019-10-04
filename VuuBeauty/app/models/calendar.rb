class Calendar < ApplicationRecord
  has_many  :timecards
  default_scope -> { order(id: :asc) }
end
