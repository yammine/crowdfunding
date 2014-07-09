class Campaign < ActiveRecord::Base

  validates :title, presence: {message: "Must be present."}
  validates :description, presence: {message: "Must be present."}
  validates :end_date, presence: {message: "Must be present."}
  validates :target, presence: {message: "Must be present."}, numericality: { greater_than_or_equal_to: 10 }

  belongs_to :user
  
  has_many :pledges, dependent: :destroy
  has_many :pledged_users, through: :pledges, source: :user

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :reward_levels, dependent: :destroy

  scope :published, -> {where(state: :published)}

  accepts_nested_attributes_for :reward_levels, allow_destroy: true,
      reject_if: proc { |x| x[:amount].blank? && x[:name].blank? && x[:details].blank? }

  self.per_page = 10

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  extend FriendlyId
  friendly_id :title, use: :slugged
  
  ##### BEEP BOOP BEEP STATE MACHINE HERE
  
  state_machine :state, initial: :draft do 
    event :publish do 
      transition draft: :published
    end

    event :expire do 
      transition published: :expired
    end

    event :cancel do 
      transition [:draft, :published] => :cancelled
    end

    after_transition on: :cancelled, do: :refund_all_pledges

  end

  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  def refund_all_pledges
    Rails.logger.info ">>>>>>>> Refunding all pledges to users."
  end



end
