class SalaryBookingTemplate < BookingTemplate
  # Obligation flags
  def self.saldo_inclusion_flags
    SalaryBookingTemplate.tag_counts_on(:include_in_saldo).pluck(:name)
  end

  def to_s
    "%s - %s" % [code, title]
  end
end
