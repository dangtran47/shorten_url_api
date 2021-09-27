class CreateMapUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :map_urls do |t|
      t.string :original_url
      t.string :shorten_url

      t.timestamps
    end
  end
end
