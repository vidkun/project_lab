class User < ActiveRecord::Base
  validates :name, :email, :phone, presence: true
  validates :name, :email, uniqueness: true
#  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/ }
end
