class SalaryReportsController < ApplicationController
  respond_to :html, :pdf

  # Filter/Search
  # =============
  before_filter do
    @by_date = Date.parse(params[:by_date][:from] || Date.today.beginning_of_year)..Date.parse(params[:by_date][:to] || Date.today.end_of_year) if params[:by_date]
    @by_date ||= Date.today.beginning_of_year..Date.today.end_of_year

    if employee_id = params[:by_employee]
      @employee = Employee.find(employee_id)
    end
  end

  def yearly_ahv_statement
    @employments = Employment.valid_during(@by_date).all
  end

  def salary_declaration
    @salaries = @employee.salaries.where(:value_date => @by_date)
    @line_items = @salaries.collect{|salary| salary.line_items}.flatten

    # TODO: better sorting
    @salary_declaration_codes = SalaryBookingTemplate.pluck(:salary_declaration_code).uniq.select{|code| code.present?}
  end

  def statistics
    @year = @by_date.first.year

    @salary_booking_templates = SalaryBookingTemplate.all
  end
end
