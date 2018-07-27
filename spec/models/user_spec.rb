# frozen_string_literal: true

require 'rails_helper'
require 'faker'

# rubocop:disable Metrics/BlockLength
RSpec.describe User, type: :model do
  context 'when using a factory' do
    let(:user) { build(:user) }

    it 'should be valid' do
      expect(user.admin?).to be_falsey
      expect(user.valid?).to be_truthy
    end

    it 'should save' do
      expect(user.save).to be_truthy
    end
  end

  context 'when email is missing' do
    let(:user) { User.new }

    it 'should not be valid' do
      expect(user.valid?).to be_falsey
    end

    it 'should not save' do
      expect(user.save).to be_falsey
    end
  end

  context 'when email is present' do
    let(:user) { User.new }

    it 'should be valid' do
      password = SecureRandom.base58(24)

      user.email = Faker::Internet.email
      user.password = password
      user.password_confirmation = password

      expect(user.valid?).to be true
    end

    it 'should save' do
      password = SecureRandom.base58(24)

      user.email = Faker::Internet.email
      user.password = password
      user.password_confirmation = password

      expect(user.save).to be true
    end

    it 'should not have a duplicate' do
      another_user = create(:user)

      password = SecureRandom.base58(24)

      user.email = another_user.email
      user.password = password
      user.password_confirmation = password

      expect(user.valid?).to be_falsey
      expect(user.errors[:email].first).to eq('has already been taken')

      user.email = another_user.email.capitalize
      expect(user.valid?).to be_falsey
      expect(user.errors[:email].first).to eq('has already been taken')
    end
  end
end
# rubocop:enable Metrics/BlockLength
