FactoryGirl.define do 
  
  factory :campaign do 
    association   :user, factory: :user
    title         Faker::Company.bs
    description   Faker::Lorem.paragraph
    target        Faker::Number.number(3)
    end_date      (Time.now + 30.days)  

  end

end