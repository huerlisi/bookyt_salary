class SalariesController < InvoicesController
  respond_to :html, :pdf
  
  # Filter/Search
  # =============
  has_scope :by_state
  has_scope :by_value_period, :using => [:from, :to], :default => proc { |c| c.session[:has_scope] }
  has_scope :by_employee_id

  # Actions
  # =======
  def statistics
    index!
  end

  def select_employee
    # Allow pre-seeding some parameters
    salary_params = {
      :customer_id    => current_tenant.company.id,
      :state          => 'booked',
      :duration_from  => Date.today,
      :duration_to    => Date.today.in(30.days).to_date
    }

    # Set default parameters
    salary_params.merge!(params[:salary]) if params[:salary]

    @salary = Salary.new(salary_params)
  end

  def new
    @salary = Salary.new(params[:salary])

    employment = @salary.employee.employments.current

    @salary.amount = employment.salary_amount

    # Line Items
    line_item = @salary.line_items.build(
      :times            => 1,
      :quantity         => 'x',
      :booking_template => BookingTemplate.find_by_code('salary:employee:ahv_iv_eo')
    )

    # Prebuild an empty attachment instance
    @salary.attachments.build

    new!
  end

  def create
    @salary = Salary.new(params[:salary])
    @salary.build_booking

    create!
  end

  def payslip
    show! do |format|
      format.html { redirect_to :action => :show }
    end
  end
end
