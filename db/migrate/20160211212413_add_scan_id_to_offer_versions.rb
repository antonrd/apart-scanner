class AddScanIdToOfferVersions < ActiveRecord::Migration
  def change
    default_scan = Scan.create(pages: 0)
    add_column :offer_versions, :scan_id, :integer, null: false, default: default_scan.id
  end
end
