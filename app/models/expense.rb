class Expense < AppllicationRecord
  belogns_to :group
  has_many :group_expenses
end