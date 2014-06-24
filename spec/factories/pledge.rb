FactoryGirl.define do 
  
  factory :pledge do 
    association   :user, factory: :user
    association   :campaign, factory: :campaign
    amount        Faker::Number.number(3)
  end

end