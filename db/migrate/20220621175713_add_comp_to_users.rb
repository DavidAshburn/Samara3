class AddCompToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :comp, :string
  end
end
