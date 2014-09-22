require 'rails_helper'

RSpec.describe User, :type => :model do
  context "when a new user is about to created" do
    it 'should have name' do
      user = User.new()
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to eq(["can't be blank"])
    end

    it 'should have a valid phone' do
      user = build(:user)
      expect(user.valid?).to eq(false)
      expect(user.errors[:phone]).to include("is not a number")
      expect(user.errors[:phone]).to include("is the wrong length (should be 10 characters)")
    end
  end
end
