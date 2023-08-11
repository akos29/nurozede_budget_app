class GroupExpense < ApplicationRecord
  belongs_to :group 
  belongs_to :expense  

  validates :group_id, presence: true
  validates :expense_id, presence: true
end