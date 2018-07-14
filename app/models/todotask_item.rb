# frozen_string_literal: true

# :nodoc:
class TodotaskItem < ApplicationRecord
  belongs_to :list
  has_many :tags, dependent: :nullify
  has_many :notes, dependent: :nullify
end
