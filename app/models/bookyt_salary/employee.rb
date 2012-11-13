module BookytSalary
  module Employee
    extend ActiveSupport::Concern

    included do
      # Associations
      has_many :salaries, :foreign_key => :company_id

      has_many :salary_templates, :foreign_key => :person_id
    end
  end
end
