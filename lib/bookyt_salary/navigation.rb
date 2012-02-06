module BookytSalary
  module Navigation
    def setup_bookyt_salary(navigation)
      navigation.item :salaries, t_title(:index, Salary), salaries_path,
                   :if => Proc.new { user_signed_in? } do |salaries|
        salaries.item :salaries, t_title(:index, Salary), salaries_path, :highlights_on => /\/salaries($|\/[0-9]*($|\/.*))/
        salaries.item :new_salary, t_title(:new, Salary), select_employee_salaries_path
        salaries.item :divider, "", :class => 'divider'
        salaries.item :salary_booking_template_statistics, t_title(:statistics, SalaryBookingTemplate), statistics_salary_booking_templates_path
        salaries.item :divider, "", :class => 'divider'
        salaries.item :salary_booking_templates, t_title(:index, SalaryBookingTemplate), salary_booking_templates_path
        salaries.item :salary_templates, t_title(:index, SalaryTemplate), salary_templates_path
      end
    end
  end
end
