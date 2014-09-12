class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :description, presence: true
  validates :description, length: { minimum: 50 }
  validates :delivery_minutes, numericality: { only_integer: true,
                                               greater_than: 0 }
end
