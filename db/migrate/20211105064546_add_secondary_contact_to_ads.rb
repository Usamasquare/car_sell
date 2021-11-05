class AddSecondaryContactToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :secondary_contact, :string
  end
end
