class AddGithubTokenColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_state, :string
    add_column :users, :github_access_token, :string
  end
end
