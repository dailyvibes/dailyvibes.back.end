# frozen_string_literal: true

# :nodoc:
class Tag < ApplicationRecord
  belongs_to :todotask_item

  validates :label, presence: true
end
