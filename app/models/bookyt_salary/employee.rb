module BookytSalary
  module Employee
    extend ActiveSupport::Concern

    included do
      has_many :salary_templates, :foreign_key => :person_id
    end
  end
end
