# frozen_string_literal: true

require 'faker'

# :nodoc:
FactoryBot.define do
  factory :list do
    title Faker::String.random
    association :user, factory: :user, strategy: :build
  end
end
