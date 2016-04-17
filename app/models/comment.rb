class Comment < ActiveRecord::Base
  belongs_to :offer

  validates :offer, presence: true
  validates :content, presence: true
end
