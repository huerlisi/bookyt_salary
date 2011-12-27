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
      
  def employment
    employee.employments.current
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

  # Calculations
  def net_amount
    salary_invoice_booking = bookings.where(:debit_account_id => Account.find_by_code('2050').id).first
    return 0.0 unless salary_invoice_booking

    salary_invoice_booking.amount
  end

  def bvg_amount
    bookings.by_text("BVG").sum(:amount)
  end

  def social_amount
    result = bookings.by_text("AHV/IV/EO Arbeitnehmer").sum(:amount)
    result += bookings.by_text("ALV Arbeitnehmer").sum(:amount)
    result += bookings.by_text("NBU Arbeitnehmer").sum(:amount)

    result
  end

  def ahv_amount
    result = amount
    result += bookings.where(:title => "Kinderzulage").sum(:amount)

    result
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

  # Filter/Search
  # =============
  scope :by_value_period, lambda {|from, to| where("date(value_date) BETWEEN ? AND ?", from, to) }
  scope :by_employee_id, lambda {|value| where(:company_id => value)}

  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("2050")
  end

  def self.available_credit_accounts
    Account.by_type(['costs', 'current_assets'])
  end

  def self.default_credit_account
    Account.find_by_code('5000')
  end

  def self.available_debit_accounts
    Account.by_type(['outside_capital'])
  end

  def self.default_debit_account
    self.direct_account
  end

  # Bookings
  # ========
  def amount
    employment.salary_amount if employment
  end

  # Build booking
  #
  # We need to ensure the order of creation as we depent on current balance.
  def build_booking(params = {}, template_code = nil)
    # Build and assign booking
    super(params, 'salary:invoice')
    super(params, 'salary:employee:ahv_iv_eo')
    super(params, 'salary:employer:ahv_iv_eo')
    super(params, 'salary:employee:alv')
    super(params, 'salary:employer:alv')
    super(params, 'salary:employee:nbu')
    super(params, 'salary:employer:nbu')
    super(params, 'salary:employer:bu')
    super(params, 'salary:employer:fak')
    super(params, 'salary:employer:vkb')

    super(params, 'salary:employee:ktg')
    super(params.merge(:person_id => employee.id), "salary:bvg")

    super(params.merge(:person_id => employee.id), "salary:kz")
    super(params.merge(:person_id => employee.id), "salary:social:kz")
  end
end
