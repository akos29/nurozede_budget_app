class GroupExpense < ApplicationRecord
  belongs_to :group
  belongs_to :expense
  has_many :expenses, through: :group_expenses
  has_many :groups, through: :group_expenses
end