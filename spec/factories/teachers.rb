FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :teacher do
    name     'John Doe'
    email
    password '12345678'
  end
end
