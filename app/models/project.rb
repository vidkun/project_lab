class Project < ActiveRecord::Base
  has_many :tasks
  has_many :project_members
  has_many :users, through: :project_members

  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :project_members, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 50, 
                                    message: 'description must be more than 50 characters'}
  validate :past_due_date

  def past_due_date
    if due_date_at <=  Time.now
      errors.add(:due_date_at, "can't be in the past")
    end
  end

end