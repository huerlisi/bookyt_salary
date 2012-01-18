# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :salary_item do
    salary_booking_template_id 1
    salary_template_id 1
    times "9.99"
    price "9.99"
  end
end
