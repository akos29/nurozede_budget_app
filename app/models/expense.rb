class Expense < ApplicationRecord
  has_many :group_expenses, dependent: :destroy
  has_many :groups, through: :group_expenses, dependent: :destroy
  belongs_to :user, class_name: 'User'

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
