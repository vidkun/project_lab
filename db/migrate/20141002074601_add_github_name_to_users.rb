class AddGithubNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_username, :string, after: :is_admin
  end
end
