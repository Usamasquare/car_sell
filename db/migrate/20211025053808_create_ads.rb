class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      t.string :city
      t.integer :mileage
      t.string :car_make
      t.string :price
      t.string :engine_type
      t.string :transmission
      t.integer :engine_capacity
      t.string :color
      t.string :assembly_type
      t.text :description

      t.timestamps
    end
  end
end
