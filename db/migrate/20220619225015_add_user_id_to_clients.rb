class AddUserIdToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :user_id, :integer
    add_index :clients, :user_id
  end
end
