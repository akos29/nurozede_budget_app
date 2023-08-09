class Group < AppllicationRecord
  belogns_to :user
  has_many :group_expenses
end