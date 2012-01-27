class SalaryTemplate < ActiveRecord::Base
  belongs_to :person

  # Salary Items
  has_many :salary_items
  accepts_nested_attributes_for :salary_items, :allow_destroy => true, :reject_if => :all_blank

  def to_s
    title
  end
end
