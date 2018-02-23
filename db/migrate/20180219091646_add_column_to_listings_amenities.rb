class AddColumnToListingsAmenities < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :amenities, :text, array:true, default:[]
  end
end


#https://stackoverflow.com/questions/32409820/add-an-array-column-in-rails