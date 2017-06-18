FactoryGirl.define do
  factory :student do
    name 'Student'
    email 'student@example.com'
    password '123123123'
    works_on = 'ONG'
    scholarity_level = 'Mestrado'
    field_of_operation = 'Direito'
  end
end
