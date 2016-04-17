class OfferVersion < ActiveRecord::Base
  belongs_to :offer
  belongs_to :scan

  validates :offer, presence: true
  validates :scan, presence: true

  scope :by_date, -> { order('created_at desc') }
end
