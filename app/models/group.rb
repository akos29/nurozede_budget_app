class Group < ApplicationRecord
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'

  def total_expenses_amount
    expenses.sum(:amount)
  end
end