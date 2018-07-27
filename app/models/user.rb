# frozen_string_literal: true

# :nodoc:
class User < ApplicationRecord
  has_secure_password

  has_many :lists, dependent: :destroy

  validates_uniqueness_of :email, case_sensitive: false, allow_blank: false
  # validates_presence_of :email
  validates :email, presence: true
  # validates :password, length: { minimum: 8 }, allow_nil: true
end
