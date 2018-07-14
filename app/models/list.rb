# frozen_string_literal: true

# :nodoc:
class List < ApplicationRecord
  has_many :todotask_items, dependent: :nullify
  belongs_to :user
end
