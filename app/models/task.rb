class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 50 }
  validates :delivery_minutes, numericality: { greater_than: 0 }


  def authorized?(user, action, project=nil)
    case action
    when 'new'
      return true if project.members.include? user
    when 'update', 'destroy'
      return true if self.user == user
    end
  end

  private
  def user_is_a_project_member
    self.users << self.creator
  end
end
