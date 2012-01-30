class SalaryBookingTemplatesController < BookingTemplatesController
  defaults :resource_class => SalaryBookingTemplate

  def copy
    # Duplicate original record
    template = resource.dup

    # Rebuild positions
    set_resource_ivar template

    render 'edit'
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
