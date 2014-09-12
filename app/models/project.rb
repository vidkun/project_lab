class Project < ActiveRecord::Base
  has_many :tasks
  validates :name, :description, :due_date_at, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 50 }
  validates_each :due_date_at do |record, attr, value|
    record.errors.add(attr, 'must be in the future') unless value.future?
  end
end
