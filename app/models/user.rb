class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :project_members
  has_many :projects, -> {distinct}, through: :project_members
  has_many :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, presence: true
  validate :name_is_not_test
  validates :phone, numericality: { greater_than: 0 }, length: { is: 10 }

  def delete_task(task)
    task_to_delete = self.tasks.find_by(id: task.id)
    task_to_delete ||= task if task.creator == self
    task_to_delete.destroy if task_to_delete
  end

  def can_edit_task?(task)
    self.tasks.find_by(id: task.id) || task.creator == self
  end

  def can_delete_task?(task)
    task.creator == self
  end

  def delete_member(project, member)
    member_to_delete = member if project.creator == self
    member_to_delete.destroy if member_to_delete
  end

  def can_add_member?(project)
    project.creator == self
  end

  def can_edit_project?(project)
    project.creator == self
  end

  private
  def name_is_not_test
    errors.add(:name, 'cannot be test') if self.name == 'test'
  end
end
