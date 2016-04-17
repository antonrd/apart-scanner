class AddFirstScanToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :first_scan_id, :integer

    Offer.update_all(first_scan_id: Scan.by_date.first.id)

    change_column_null(:offers, :first_scan_id, false)
  end
end
