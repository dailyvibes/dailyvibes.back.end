# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe List, type: :model do
  context 'when using a factory' do
    let(:list) { build(:list) }

    it 'should be valid' do
      expect(list.new_record?).to be_truthy
      expect(list.user.new_record?).to be_truthy
      expect(list.valid?).to be_truthy
      expect(list.user.valid?).to be_truthy
    end

    it 'should save' do
      expect(list.save).to be_truthy
      expect(list.user.new_record?).to be_falsey
    end
  end

  context 'when user is missing' do
    let(:list) { List.new }

    it 'should not be valid' do
      expect(list.valid?).to be_falsey
    end

    it 'should not save' do
      expect(list.save).to be_falsey
      expect(list.errors[:user].first).to eq('must exist')
    end
  end

  context 'when title is missing' do
    let(:list) do
      List.new(user: build(:user))
    end

    it 'should not be valid' do
      expect(list.valid?).to be_falsey
    end

    it 'should not save' do
      expect(list.save).to be_falsey
    end
  end

  context 'when title is present' do
    let(:list) do
      List.new(title: Faker::String.random, user: build(:user))
    end

    it 'should be valid' do
      expect(list.valid?).to be_truthy
    end

    it 'should save' do
      expect(list.save).to be_truthy
    end
  end
end
# rubocop:enable Metrics/BlockLength
