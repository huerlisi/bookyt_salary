class SalaryReportsController < ApplicationController
  respond_to :html, :pdf

  before_filter do
    @value_period = Date.parse(params[:by_value_period][:from] || Date.today.beginning_of_year)..Date.parse(params[:by_value_period][:to] || Date.today.end_of_year) if params[:by_value_period]
    @value_period ||= Date.today.beginning_of_year..Date.today.end_of_year
  end

  def yearly_ahv_statement
    @employments = Employment.valid_during(@value_period).all
  end

  def salary_declaration
    @employee = Employee.find(params[:employee_id])
    @salaries = @employee.salaries.where(:value_date => @value_period)
    @line_items = @salaries.collect{|salary| salary.line_items}.flatten

    # TODO: better sorting
    @salary_declaration_codes = SalaryBookingTemplate.pluck(:salary_declaration_code).uniq.select{|code| code.present?}
  end

  def statistics
    if params['date']
      date = Date.parse(params['date'])
    else
      date = Date.today
    end

    @duration = date.beginning_of_month..date.end_of_month
    @salary_booking_templates = SalaryBookingTemplate.all
  end
end
