# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Tag, type: :model do
  context 'when using a factory' do
    let(:tag) { build(:tag) }

    it 'should be valid' do
      expect(tag.valid?).to be_truthy
    end

    it 'should save' do
      expect(tag.save).to be_truthy
    end
  end

  context 'when label is missing and task is missing' do
    let(:tag) { Tag.new }

    it 'should not be valid' do
      expect(tag.valid?).to be_falsey
      expect(tag.errors[:todotask_item].first).to eq('must exist')
      expect(tag.errors[:label].first).to eq("can't be blank")
    end

    it 'should not save' do
      expect(tag.save).to be_falsey
    end
  end

  context 'when label is missing' do
    let(:task) { create(:task) }
    let(:tag) { Tag.new(todotask_item: task) }

    it 'should not be valid' do
      expect(tag.valid?).to be_falsey
    end

    it 'should not save' do
      expect(tag.save).to be_falsey
    end
  end

  context 'when label is present' do
    let(:task) { create(:task) }
    let(:tag) { Tag.new(todotask_item: task, label: Faker::String.random) }

    it 'should be valid' do
      expect(tag.valid?).to be_truthy
    end

    it 'should save' do
      expect(tag.save).to be_truthy
    end
  end
end
# rubocop:enable Metrics/BlockLength
