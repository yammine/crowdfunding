FactoryGirl.define do 
  factory :user do 
    first_name       Faker::Name.first_name
    last_name        Faker::Name.last_name
    sequence(:email) { |n| "some_name_#{n}@gmail.com" }
    password "somevalidpassword123"
  end

end
