class SalaryBookingTemplatesController < BookingTemplatesController
  defaults :resource_class => SalaryBookingTemplate

  def copy
    # Duplicate original record
    template = resource.dup

    # Rebuild positions
    set_resource_ivar template

    render 'edit'
  end
end
