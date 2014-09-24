require 'rails_helper'

RSpec.describe User, :type => :model do
  context "when a new user is about to created" do

    context "and it has invalid fields" do

      subject { build(:user) }

      it 'check the name' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:name]).to eq(["can't be blank"])
      end

      it 'check for a valid phone' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:phone]).to include("is not a number")
        expect(subject.errors[:phone]).to include("is the wrong length (should be 10 characters)")
      end

      it 'check for a valid email' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:email]).to include("can't be blank")
      end

      it 'checks for test name' do
        user = build(:user, :name => 'test')
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("cannot be test")
      end
    end

    it 'will save with all attributes' do
      user = build(:first_user)
      Rails.logger.error user.errors
      expect(user.valid?).to eq(true)
    end
  end

  context "when is deleting a task" do
    let(:project) { create(:second_project) }
    let(:user_with_task) { create(:first_user) }

    context "and the user is assigned to the task" do
      subject! { create(:task_one, user_id: user_with_task.id) }

      it 'can be deleted' do
        user_with_task.reload
        expect{
          expect(user.delete_task(subject)).to_not be_nil
        }.to change(Task, :count).by(-1)
      end
    end

    context "and the user is NOT assigned to the task" do
      subject! { create(:task_one, user_id: create(:first_user).id) }

      it 'cannot be deleted' do
        user_with_task.reload
        expect{
          expect(user_with_task.delete_task(subject)).to be_nil
        }.to change(Task, :count).by(0)
      end
    end
  end


end
