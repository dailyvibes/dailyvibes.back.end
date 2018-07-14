# frozen_string_literal: true

# :nodoc:
class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes, id: :uuid do |t|
      t.string :title
      t.text :content
      t.datetime :completed_at
      t.datetime :archived_at
      t.boolean :public, default: false
      t.boolean :favourite, default: false
      t.belongs_to :todotask_item, type: :uuid, index: true

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
