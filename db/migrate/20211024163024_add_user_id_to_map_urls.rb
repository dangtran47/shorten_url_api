class AddUserIdToMapUrls < ActiveRecord::Migration[6.1]
  def change
    add_column :map_urls, :user_id, :integer
  end
end
