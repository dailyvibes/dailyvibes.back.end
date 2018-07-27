# frozen_string_literal: true

require 'faker'

# :nodoc:
FactoryBot.define do
  factory :todotask_item, aliases: [:task] do
    title Faker::String.random
    association :list, factory: :list, strategy: :build
  end
end
