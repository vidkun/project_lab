class ProjectMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, numericality: { greater_than: 0,
                                      only_integer: true }
end
