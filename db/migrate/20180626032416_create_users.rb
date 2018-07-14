# frozen_string_literal: true

# :nodoc:
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false
      t.string :role, default: '[\'guest\']'

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
