class SalaryBookingTemplate < BookingTemplate
  default_scope order(:code)
end
