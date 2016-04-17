class AddOffersTagsTable < ActiveRecord::Migration
  def change
    create_table :offers_tags do |t|
      t.integer :offer_id
      t.integer :tag_id
    end
  end
end
