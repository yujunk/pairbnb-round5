class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
    	t.integer :product_code
    	t.string :title
    	t.string :description
      t.timestamps
    end
  end
end
