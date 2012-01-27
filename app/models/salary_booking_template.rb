class SalaryBookingTemplate < BookingTemplate
  # Obligation flags
  def self.saldo_inclusion_flags
    ['gross_income', 'net_income', 'ahv', 'uvg', 'uvgz', 'ktg', 'deduction_at_source']
  end

  def to_s
    title
  end
end
