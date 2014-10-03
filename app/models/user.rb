class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :project_members
  has_many :projects, -> {distinct}, through: :project_members
  has_many :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:github]
  
  validates :name, presence: true
  validate :name_is_not_test
  validates :phone, numericality: { greater_than: 0 }, length: { is: 10 }

  scope :not_in_project, ->(project) { joins(:project_members).where("user_id NOT IN (?)", project.users.pluck(:id)) }
  scope :with_github_state, ->(state_param) { where(github_state: state_param).where.not(github_state: nil) }

  def delete_task(task)
    task_to_delete = self.tasks.find_by(id: task.id)
    task_to_delete ||= task if task.creator == self
    task_to_delete.destroy if task_to_delete
  end

  def can_delete_task?(task)    
    task.creator == self
  end

  def can_edit_task?(task)
    self.tasks.find_by(id: task.id) || task.creator == self
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

  def generate_github_state!
    self.update_attributes(github_state: self.generate_github_state)
    self.github_state
  end

  def generate_github_state
    SecureRandom.hex
  end

  def authorized_for_github!(authorized_token)
    self.update_attributes(github_access_token: authorized_token, github_state: 'completed')
  end

  def is_github_authorized?
    self[:github_access_token] && self[:github_state] == 'completed'
  end

  private
  def name_is_not_test
    errors.add(:name, 'cannot be test') if self.name == 'test'
  end
end
