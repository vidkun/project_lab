class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :description, presence: true
  validates :name, uniqueness: true
end
