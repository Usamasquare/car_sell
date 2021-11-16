class AddStatusToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :status, :integer
  end
end
