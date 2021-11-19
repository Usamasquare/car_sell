class ChangePriceColumn < ActiveRecord::Migration[6.1]
  def up
    change_column :ads, :price, 'numeric USING CAST(price AS numeric)'
  end
  def down
    change_column :ads, :price, :string
  end
end
