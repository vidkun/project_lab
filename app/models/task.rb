class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 50 }
  validates :delivery_minutes, numericality: { greater_than: 0 }
  scope :completed, -> { where(is_completed: true) }
end
