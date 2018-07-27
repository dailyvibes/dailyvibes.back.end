# frozen_string_literal: true

require 'faker'

# :nodoc:
FactoryBot.define do
  factory :tag do
    label Faker::String.random

    association :todotask_item, factory: :todotask_item, strategy: :build
  end
end
