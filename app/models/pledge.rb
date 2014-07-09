class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  has_one :order

  validates :amount, presence: true, numericality: {greater_than: 0}

  state_machine :state, initial: :pending do 
    event :pay do 
      transition pending: :paid
    end
  end

  
end
