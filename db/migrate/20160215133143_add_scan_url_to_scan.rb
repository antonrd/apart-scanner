class AddScanUrlToScan < ActiveRecord::Migration
  def change
    add_column :scans, :scan_url_id, :integer

    scan_url = ScanUrl.create(
      name: 'all_after_2001',
      url: "http://www.imot.bg/pcgi/imot.cgi?act=3&slink=24h7g8&f1=",
      url_suffix: ""
    )

    Scan.update_all(scan_url_id: scan_url.id)

    change_column_null(:scans, :scan_url_id, false)
  end
end
