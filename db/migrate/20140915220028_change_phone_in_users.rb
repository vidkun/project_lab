class ChangePhoneInUsers < ActiveRecord::Migration
  def change
    change_column :users, :phone, :bigint
  end
end
