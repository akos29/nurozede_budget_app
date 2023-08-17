class Group < ApplicationRecord
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses, dependent: :destroy
  belongs_to :user
  has_one_attached :icon_image

  validates :user_id, presence: true
  validates :name, presence: true
  validates :name, length: { minimum: 3 }
  validates_uniqueness_of :name, scope: :user_id, message: ' already exist'

  validate :acceptable_image
  def acceptable_image
    return unless icon_image.attached?

    errors.add(:icon_image, 'is too big') unless icon_image.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(icon_image.content_type)

    errors.add(:icon_image, 'must be a JPEG or PNG')
  end

  def total_expenses_amount
    expenses.sum(:amount)
  end
end
