class Campaign < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true
  validates :end_date, presence: true
  validates :target, presence: true, numericality: { greater_than_or_equal_to: 10 }

  belongs_to :user


end
