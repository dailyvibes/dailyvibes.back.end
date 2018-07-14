# frozen_string_literal: true

# :nodoc:
class CreateLists < ActiveRecord::Migration[5.2]
  def up
    create_table :lists, id: :uuid do |t|
      t.string :title
      t.datetime :duedate_at
      t.datetime :archived_at
      t.datetime :completed_at
      t.text :title_description
      t.string :emoji
      t.string :color
      t.boolean :favourite, default: false
      t.boolean :visible, default: false
      t.boolean :public, default: false
      t.boolean :dv_default, default: false
      t.belongs_to :user, index: true, type: :uuid

      # Sync
      t.boolean :synced, default: false
      t.string :synced_id
      t.datetime :sync_began_at
      t.datetime :sync_finished_at
      t.string :synced_device_id

      t.timestamps
    end

    add_column :todotask_items, :list_id, :uuid, null: false
    add_index :todotask_items, :list_id
  end

  def down
    drop_table :lists
    remove_index :todotask_items, :list_id
    remove_column :todotask_items, :list_id
  end
end
