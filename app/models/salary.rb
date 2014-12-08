class Salary < Invoice
  # Association customizing
  belongs_to :employee, :foreign_key => :company_id, :class_name => 'Employee'
  belongs_to :employer, :foreign_key => :customer_id, :class_name => 'Person'

  validates :employee, :employer, :presence => true

  def employer_id=(value)
    self.customer_id = value
  end
  def employer_id
    customer_id
  end

  def employee_id=(value)
    self.company_id = value
  end
  def employee_id
    company_id
  end

  # Emplyoment helpers
  def employment
    employee.employments.valid_at(value_date).last
  end

  def hourly_paid?
    employment.try(:hourly_paid?)
  end

  def track_hours?
    # No tracking if we have no information how payment is done
    return false if hourly_paid?.nil?

    # No tracking if paid by hour
    return false if hourly_paid?

    # No tracking if we have no current information
    return false unless work_days.present?
  end

  def track_leave_days?
    # No tracking if we have no information how payment is done
    return false if hourly_paid?.nil?

    # No tracking if paid by hour
    return false if hourly_paid?

    # No tracking if we have no current information
    return false unless used_leave_days && leave_days_balance

    # Track otherwise
    return true
  end

  # States
  # ======
  STATES = ['booked', 'canceled', 'paid']

  # String
  def to_s(format = :default)
    case format
    when :long
      "%s (%s / %s - %s)" % [title, employee, duration_from ? I18n::localize(duration_from) : '', duration_to ? I18n::localize(duration_to) : '']
    else
      title
    end
  end

  # Helpers
  def previous
    employee.salaries.order("duration_to DESC").where("duration_to < ?", duration_to).first
  end

  # Calculations
  def ahv_amount
    amount_of('AHV')
  end

  def net_amount
    # TODO: hardcoded salary_booking_template
    amount_of('6500')
  end

  def gross_amount
    # TODO: hardcoded salary_booking_template
    amount_of('5000')
  end

  def bvg_amount
    # TODO: hardcoded salary_booking_template
    amount_of('5050')
  end

  # Assignment proxies
  def duration_from=(value)
    write_attribute(:duration_from, value)

    value_as_date = self.duration_from
    # Calculate value and due dates
    date = Date.new(value_as_date.year, value_as_date.month, 1).in(1.month).ago(1.day)
    self.value_date ||= date
    self.due_date   ||= date
  end

  # Get salary template
  #
  # Tries to get a personal salary template, falls back to templates with
  # no assigned persons.
  #
  # If more than one template matches the criteria, it is unspecified which
  # one will be returned.
  def salary_template
    template = SalaryTemplate.where(:person_id => employee.id).last
    template ||= SalaryTemplate.where(:person_id => nil).last
  end

  # Line Items
  def build_line_items
    salary_template.salary_items.each do |salary_item|
      line_item = salary_item.build_line_item

      line_item.date    = self.value_date
      self.line_items << line_item
    end
  end


  # Filter/Search
  # =============
  scope :by_value_period, lambda {|from, to| where("date(value_date) BETWEEN ? AND ?", from, to) }
  scope :by_employee, lambda {|value| where(:company_id => value)}

  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("2050")
  end

  def self.available_credit_accounts
    Account.all
  end

  def self.default_credit_account
    Account.find_by_code('5000')
  end

  def self.available_debit_accounts
    Account.all
  end

  def self.default_debit_account
    self.direct_account
  end

  # bookyt_projects
  def hours_carry
    WorkDay.create_or_update_upto(employee, duration_to)
    last_day = employee.work_days.where(:date => duration_from.ago(1.day)).last

    return 0 unless last_day

    return last_day.overall_overtime
  end

  def work_days
    WorkDay.create_or_update_upto(employee, duration_to)
    employee.work_days.where(:date => duration_from..duration_to)
  end
end
