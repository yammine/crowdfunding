class RewardLevel < ActiveRecord::Base
  belongs_to :campaign

  validates :name, :amount, :details, presence: true

  validates :amount, numericality: { greater_than:  0 }
end
