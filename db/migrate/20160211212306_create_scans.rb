class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.integer :pages, null: false
      t.integer :all_offers, null: false, default: 0
      t.integer :new_offers, null: false, default: 0

      t.timestamps null: false
    end
  end
end
