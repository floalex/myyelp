class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :state, :city, :zipcode, :phone
      t.text :address
      t.timestamps 
    end
  end
end
