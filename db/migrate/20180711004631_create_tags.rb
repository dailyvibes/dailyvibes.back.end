# frozen_string_literal: true

# :nodoc:
class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :label
      t.boolean :archived, default: false
      t.boolean :public, default: false
      t.string :colour_representation
      t.string :emoji
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
