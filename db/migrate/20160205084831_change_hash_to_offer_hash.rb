class ChangeHashToOfferHash < ActiveRecord::Migration
  def change
    rename_column :offers, :hash, :offer_hash
  end
end
