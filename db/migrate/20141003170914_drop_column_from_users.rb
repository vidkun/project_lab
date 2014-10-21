class DropColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :is_admin
  end
end
