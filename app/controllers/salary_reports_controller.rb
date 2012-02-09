class SalaryReportsController < ApplicationController
  respond_to :html, :pdf
  
  # Actions
  # =======
  def yearly_ahv_statement
    @value_period = Date.parse(params[:by_value_period][:from] || Date.today.beginning_of_year)..Date.parse(params[:by_value_period][:to] || Date.today.end_of_year) if params[:by_value_period]
    @value_period ||= Date.today.beginning_of_year..Date.today.end_of_year

    @employments = Employment.valid_during(@value_period).all
  end
end
