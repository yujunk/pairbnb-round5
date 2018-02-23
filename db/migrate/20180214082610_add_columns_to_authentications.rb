class AddColumnsToAuthentications < ActiveRecord::Migration[5.1]
  def change
    add_column :authentications, :email, :string
    add_column :authentications, :password, :string
  end
end
