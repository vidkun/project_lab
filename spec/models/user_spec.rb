require 'rails_helper'

RSpec.describe User, :type => :model do
  context "when a new user is about to created" do
    it 'should have name' do
      user = build(:user)
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to eq(["can't be blank"])
    end

    it 'should have a valid phone' do
      user = build(:user)
      expect(user.valid?).to eq(false)
      expect(user.errors[:phone]).to include("is not a number")
      expect(user.errors[:phone]).to include("is the wrong length (should be 10 characters)")
    end

    it 'should have a valid email' do
      user = build(:user)
      expect(user.valid?).to eq(false)
      expect(user.errors[:email]).to include("can't be blank")
    end


    it 'will save with all attributes' do
      user = build(:first_user)
      Rails.logger.error user.errors
      expect(user.valid?).to eq(true)
    end
  end
end
