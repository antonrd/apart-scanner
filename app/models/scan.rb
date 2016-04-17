class Scan < ActiveRecord::Base
  scope :by_date, -> { order('created_at desc') }

  has_many :offer_versions
  has_many :offers, foreign_key: 'first_scan_id'
  belongs_to :scan_url

  validates :scan_url, presence: true
end
