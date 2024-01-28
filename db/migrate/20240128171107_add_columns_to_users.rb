# frozen_string_literal: true

# adds role and team reference columns to users
class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :role, :string) unless column_exists?(:users, :role)
    add_column(:users, :team_id, :integer, default: 0, null: false)
    add_index(:users, :team_id)
  end
end
