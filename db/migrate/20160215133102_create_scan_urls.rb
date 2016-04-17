class CreateScanUrls < ActiveRecord::Migration
  def change
    create_table :scan_urls do |t|
      t.string :url, null: false
      t.string :url_suffix, null: false, default: ''
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
