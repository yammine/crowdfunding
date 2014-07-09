class Order < ActiveRecord::Base

  attr_accessor :stripe_card_token

  belongs_to :pledge
end
