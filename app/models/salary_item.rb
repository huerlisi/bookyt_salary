class SalaryItem < ActiveRecord::Base
  # Ordering
  default_scope order(:position)

  # Associations
  belongs_to :salary_template
  belongs_to :salary_booking_template

  def build_line_item
    # Defaults from booking_template
    line_item = salary_booking_template.build_line_item

    # Overrides from salary_item
    line_item.times    = self.times if self.times.present?
    line_item.price    = self.price if self.price.present?
    line_item.position = self.position if self.position.present?

    line_item
  end
end
