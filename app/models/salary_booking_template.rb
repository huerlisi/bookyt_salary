class SalaryBookingTemplate < BookingTemplate
  # Obligation flags
  def self.saldo_inclusion_flags
    # Fix: Using .pluck(:name) would be nice but gives non-deterministic behaviour (id instead of name, sometimes)
    SalaryBookingTemplate.tag_counts_on(:include_in_saldo).map{|tag| tag.name}
  end

  def to_s
    "%s - %s" % [code, title]
  end
end
