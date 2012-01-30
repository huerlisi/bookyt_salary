class SalaryBookingTemplate < BookingTemplate
  # Obligation flags
  def self.saldo_inclusion_flags
    ['gross_income', 'net_income', 'payment', 'ahv', 'uvg', 'uvgz', 'ktg', 'deduction_at_source']
  end

  def to_s
    "%s - %s" % [code, title]
  end
end
