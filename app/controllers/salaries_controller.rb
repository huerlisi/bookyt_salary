class SalariesController < InvoicesController
  defaults :resource_class => Salary

  respond_to :html, :pdf
  
  # Filter/Search
  # =============
  has_scope :invoice_state, :default => nil
  has_scope :by_value_period, :using => [:from, :to], :default => proc { |c| c.session[:has_scope] }
  has_scope :by_employee_id

  # Actions
  # =======
  def select_employee
    # Allow pre-seeding some parameters
    salary_params = {
      :duration_from  => Date.today.beginning_of_month
    }

    # Set default parameters
    salary_params.merge!(params[:salary]) if params[:salary]

    @salary = Salary.new(salary_params)
  end

  def new
    @salary = Salary.new(params[:salary])
    @salary.state = 'booked'

    unless @salary.employee
      # Trigger validation to flag bad values in select form
      @salary.valid?

      render :action => 'select_employee' and return
    end

    # Deduced defaults
    @salary.employer_id = current_tenant.company.id
    month_name          = t('date.month_names')[@salary.duration_from.month]
    @salary.title       = "Lohn #{month_name} #{@salary.duration_from.year} - #{@salary.employee.vcard.full_name}"
    @salary.duration_to = @salary.duration_from.end_of_month

    @salary.leave_days_balance = @salary.previous.try(:leave_days_balance) || 0
    @salary.used_leave_days = 0

    # Prebuild line items
    @salary.build_line_items

    # Prebuild an empty attachment instance
    @salary.attachments.build

    new!
  end

  def payslip
    @salary = Salary.find(params[:id])

    @include_hours_table = @salary.track_hours?
    @include_leave_days_table = @salary.track_leave_days?

    if @include_hours_table
      @hours_carry = @salary.hours_carry

      work_days = @salary.work_days
      @hours_due = work_days.sum(:hours_due)
      @hours_worked = work_days.sum(:hours_worked)
      @hours_saldo = work_days.last.overall_overtime
    end

    show! do |format|
      format.html { redirect_to :action => :show }
    end
  end
end
