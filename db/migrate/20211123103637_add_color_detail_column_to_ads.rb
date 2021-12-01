class AddColorDetailColumnToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :color_detail, :string
  end
end
