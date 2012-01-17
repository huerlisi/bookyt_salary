class SalaryTemplate < ActiveRecord::Base
  belongs_to :person
  has_and_belongs_to_many :salary_booking_template
end
