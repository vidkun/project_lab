require 'rails_helper'

RSpec.describe Task, :type => :model do
  context "when a new task is created" do
    context "and it has invalid fields" do
      subject { build(:task)}

      it 'check for name' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:name]).to include("can't be blank")
      end

      it 'check for description length' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:description]).to include("is too short (minimum is 50 characters)")
      end

      it 'check delivery_minutes is a number' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:delivery_minutes]).to include("is not a number")
      end

      it 'check for duplicate name' do
        task = create(:task_one)
        subject = build(:task, name: "Task name")
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:name]).to include("has already been taken")
      end
    end
  end
end
