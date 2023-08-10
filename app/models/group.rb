class Group < ApplicationRecord
  belongs_to :user
  has_many :group_expenses
  has_many :expenses, through: :group_expenses

  validates :name, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :group_expenses

  def total_expenses_amount
    expenses.sum(:amount)
  end
end