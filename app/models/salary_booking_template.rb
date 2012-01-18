class SalaryBookingTemplate < BookingTemplate
  default_scope order(:code)

  # Obligation flags
  OBLIGATION_FLAGS = [:for_gross_income, :for_ahv, :for_uvg, :for_uvgz, :for_ktg, :for_deduction_at_source]
  def obligation=(value)
    OBLIGATION_FLAGS.each do |flag|
      self[flag] = value.include?(flag.to_s)
    end
  end

  def obligation
    result = []
    OBLIGATION_FLAGS.each do |flag|
      result << flag.to_s if self[flag]
    end

    result
  end
end
