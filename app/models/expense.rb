class Expense < ApplicationRecord
  has_many :group_expenses, dependent: :destroy
  has_many :groups, through: :group_expenses, dependent: :destroy
  belongs_to :user, class_name: 'User'

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # after_create :create_group_expense

  # def create_group_expense
  #   groups.each do |group|
  #     GroupExpense.create(group_id: group.id, expense_id: id)
  #     group.update_total_expense_amount
  #   end
  # end
end
