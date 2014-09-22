require 'rails_helper'

RSpec.describe Project, :type => :model do
  context "when a new project is about to created" do

    it 'will not save with empty attributes' do
      project = build(:project)
      Rails.logger.error project.errors
      expect(project.valid?).to eq(false)
    end

    context "and it has invalid fields" do

      subject { build(:first_project) }

      it 'should not have a blank name' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:name]).to eq(["can't be blank"])
      end

      it 'should fail with a description < 50 characters' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:description]).to eq(["description must be more than 50 characters"])
      end

      it 'should not have a due date in the past' do
        expect(subject.valid?).to eq(false)
        # expect(subject.errors[:due_date_at].any?)
      end

    end

    context "and it has valid fields" do

      subject { build(:second_project) }

      it 'should have a name' do
        expect(subject.valid?).to eq(true)
        expect(subject.errors[:name].any?).to eq(false)
      end

      it 'should have a unique name' do
        expect(subject.valid?).to eq(true)
        subject.save!
        
        new_project = build(:second_project)
        expect(new_project.valid?).to eq(false)
        expect(new_project.errors[:name]).to include("has already been taken")
      end

      it 'should have a description of at least 50 characters' do
        expect(subject.valid?).to eq(true)
        expect(subject.errors[:description].any?).to eq(false)
      end

      it 'should have a due date in the future' do
        expect(subject.valid?).to eq(true)
        expect(subject.errors[:due_date_at].any?).to eq(false)
      end

    end
  end
end
