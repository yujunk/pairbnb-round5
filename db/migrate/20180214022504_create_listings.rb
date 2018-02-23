class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
    	t.string :title
    	t.string :description
    	t.string :location
    	t.integer :price_per_night
      t.timestamps
    end

   add_reference :listings, :user, foreign_key: true 
  end
end
