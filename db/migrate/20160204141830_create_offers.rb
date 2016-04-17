class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.boolean :hidden
      t.integer :price
      t.string :hood

      t.timestamps null: false
    end
  end
end
