# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :note do
    title Faker::String.random
    content %{
      # Add notes

      ## Use Markdown

      - MAKE
      - LISTS

      Even add links like so: [my search engine](https://duckduckgo.com)
    }

    association :todotask_item, factory: :todotask_item, strategy: :build
  end
end
