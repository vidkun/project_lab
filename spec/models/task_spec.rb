require 'rails_helper'

RSpec.describe Task, :type => :model do
  context "when a new task is created" do
    context "and it has invalid fileds" do
      subject { build(:task)}

      it 'check for name' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end
  end
end
