class GroupExpense < ApplicationRecord
  belongs_to :group
  belongs_to :expense

  validates :group_id, presence: true
  validates :expense_id, presence: true

  after_create :update_total_expense_amount
  after_destroy :update_total_expense_amount

  private

  def update_total_expense_amount
    group.update_total_expense_amount
  end
end
