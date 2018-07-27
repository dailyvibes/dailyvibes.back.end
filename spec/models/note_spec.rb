# frozen_string_literal:true

require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'when using a factory' do
    let(:note) { build(:note) }

    it 'should be valid' do
      expect(note.valid?).to be_truthy
    end

    it 'should save' do
      expect(note.save).to be_truthy
    end
  end

  context 'when content is missing and task is missing' do
    let(:note) { Note.new }

    it 'should not be valid' do
      expect(note.valid?).to be_falsey
      expect(note.errors[:todotask_item].first).to eq('must exist')
      expect(note.errors[:content].first).to eq("can't be blank")
    end

    it 'should not save' do
      expect(note.save).to be_falsey
    end
  end

  context 'when content is missing' do
    let(:task) { create(:task) }
    let(:note) { Note.new(todotask_item: task) }

    it 'should not be valid' do
      expect(note.valid?).to be_falsey
      expect(note.errors[:content].first).to eq("can't be blank")
    end

    it 'should not save' do
      expect(note.save).to be_falsey
    end
  end
end
