class CreateOfferVersions < ActiveRecord::Migration
  def change
    create_table :offer_versions do |t|
      t.text :html_content

      t.timestamps null: false
    end
  end
end
