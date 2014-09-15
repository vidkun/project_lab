class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 50 }
  validates :delivery_minutes, numericality: { greater_than: 0 }
end
