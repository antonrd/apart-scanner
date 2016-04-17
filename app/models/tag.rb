class Tag < ActiveRecord::Base
  has_and_belongs_to_many :offers

  validates :label, presence: true, uniqueness: true
end
