# frozen_string_literal: true

# :nodoc:
class Note < ApplicationRecord
  belongs_to :todotask_item
end
