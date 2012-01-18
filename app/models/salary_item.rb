class SalaryItem < ActiveRecord::Base
  # Ordering
  default_scope order(:position)

  # Associations
  belongs_to :salary_template
  belongs_to :salary_booking_template
end
