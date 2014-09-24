class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 50 }
  validates :delivery_minutes, numericality: { greater_than: 0 }

  private
  def user_is_a_project_member
    self.users << self.creator
  end
end
