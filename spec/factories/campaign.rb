FactoryGirl.define do 
  
  factory :campaign do 
    association   :user, factory: :user
    sequence(:title) {|n| "#{Faker::Company.bs} - #{n}"}
    description   Faker::Lorem.paragraph
    target        Faker::Number.number(3)
    end_date      (Time.now + 30.days)  

  end

end