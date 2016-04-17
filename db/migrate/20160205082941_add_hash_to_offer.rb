class AddHashToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :hash, :string, null: false

    add_index :offers, :hash, unique: true
  end
end
