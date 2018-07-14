# frozen_string_literal: true

# :nodoc:
class CreateTodotaskItems < ActiveRecord::Migration[5.2]
  def change
    create_table :todotask_items, id: :uuid do |t|
      t.string :title
      t.datetime :duedate_at
      t.datetime :archived_at
      t.datetime :completed_at
      t.boolean :completed, default: false
      t.boolean :archived, default: false
      t.boolean :new, default: true
      t.boolean :public, default: false
      t.boolean :favourite, default: false
      t.boolean :remindable, default: false

      # Sync
      t.boolean :synced, default: false
      t.string :synced_id
      t.datetime :sync_began_at
      t.datetime :sync_finished_at
      t.string :synced_device_id

      t.timestamps
    end
  end
end
