class Expense < ApplicationRecord
  belongs_to :user
  has_many :group_expenses
  has_many :groups, through: :group_expenses

  validates :name, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

end