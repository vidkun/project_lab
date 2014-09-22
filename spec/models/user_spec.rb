require 'rails_helper'

RSpec.describe User, :type => :model do
  context "when a new user is about to created" do
    it 'should have name' do
      user = User.new()
      expect(user.valid?).to eq(false)
      expect(user.errors[:name]).to eq(["can't be blank"])
    end
  end
end
