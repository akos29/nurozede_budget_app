class User < AppllicationRecord
  has_many :groups
  has_many :expenses, through: :groups
end
