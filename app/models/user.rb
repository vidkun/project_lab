class User < ActiveRecord::Base
  before_validation(on: [:create, :update]) do
    self.phone = phone.gsub(/[^0-9]/, "") if attribute_present?("phone")
  end
  validates :name, :email, :phone, presence: true
  validates :name, :email, uniqueness: true
  validates :phone, format: { with: /\d{10}/ }

end
