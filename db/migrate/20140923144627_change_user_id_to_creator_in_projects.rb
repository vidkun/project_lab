class ChangeUserIdToCreatorInProjects < ActiveRecord::Migration
  def change
    add_column :projects, :creator, :string
    remove_reference :projects, :user, index: true

  end
end
