class GroupExpense < ApplicationRecord
  belongs_to :group 
  belongs_to :expense 

  validates :group_id, presence: true
  validates :expense_id, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def self.total_amount
    sum(:amount)
  end

  def self.total_amount_by_group(group_id)
    where(group_id: group_id).sum(:amount)
  end

  def self.total_amount_by_expense(expense_id)
    where(expense_id: expense_id).sum(:amount)
  end

  def self.total_amount_by_group_and_expense(group_id, expense_id)
    where(group_id: group_id, expense_id: expense_id).sum(:amount)
  end
end