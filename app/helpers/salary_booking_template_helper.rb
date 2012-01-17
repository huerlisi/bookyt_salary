module SalaryBookingTemplateHelper
  def obligation_collection
    obligations = SalaryBookingTemplate::OBLIGATION_FLAGS.map{|obligation| [t_attr(obligation), obligation.to_s]}
  end
end
