class Offer < ActiveRecord::Base
  scope :interesting, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :by_date, -> { order('created_at desc') }

  has_many :offer_versions
  has_many :comments
  has_and_belongs_to_many :tags
  belongs_to :first_scan, class_name: 'Scan', foreign_key: 'first_scan_id'

  validates :first_scan, presence: true

  def last_version
    @last_version ||= offer_versions.by_date.first
  end

  def last_version_date
    last_version.created_at
  end
end
