# frozen_string_literal: true

require 'faker'

# :nodoc:
FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password 'passowrd'
    password_confirmation 'passowrd'
    admin false
  end
end
