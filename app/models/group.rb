class Group < ApplicationRecord
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true
  validates :name, length: { minimum: 3 }
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'


  def update_total_expense_amount
    self.group_total = expenses.sum(:amount)
    save
  end

  def total_expenses_amount
    expenses.sum(:amount)
  end
end
