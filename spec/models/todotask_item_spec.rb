# frozen_string_literal: true

require 'rails_helper'
require 'faker'

# rubocop:disable Metrics/BlockLength
RSpec.describe TodotaskItem, type: :model do
  context 'when using a factory' do
    let(:task) { build(:task) }

    it 'should be valid' do
      expect(task.valid?).to be_truthy
    end

    it 'should save' do
      expect(task.save).to be_truthy
    end
  end

  context 'when list is missing and list is missing' do
    let(:task) { TodotaskItem.new }

    it 'should not be valid' do
      expect(task.valid?).to be_falsey
      expect(task.errors[:list].first).to eq('must exist')
      expect(task.errors[:title].first).to eq("can't be blank")
    end

    it 'should not save' do
      expect(task.save).to be_falsey
    end
  end

  context 'when title is missing' do
    let(:list) { create(:list) }
    let(:task) { TodotaskItem.new(list: list) }

    it 'should not be valid' do
      expect(task.valid?).to be_falsey
    end

    it 'should not save' do
      expect(task.save).to be_falsey
    end
  end

  context 'when title is present' do
    let(:list) { create(:list) }
    let(:task) { TodotaskItem.new(title: Faker::String.random, list: list) }

    it 'should be valid' do
      expect(task.valid?).to be_truthy
    end

    it 'should save' do
      expect(task.save).to be_truthy
    end
  end
end
# rubocop:enable Metrics/BlockLength
