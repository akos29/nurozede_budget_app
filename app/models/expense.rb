class Expense < ApplicationRecord
  belogns_to :group
  has_many :group_expenses
end