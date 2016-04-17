class AddOfferIdToOfferVersion < ActiveRecord::Migration
  def change
    add_column :offer_versions, :offer_id, :integer, null: false
  end
end
