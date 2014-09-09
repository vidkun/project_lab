class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :description, :is_completed, presence: true
  validates :name, uniqueness: true
end
