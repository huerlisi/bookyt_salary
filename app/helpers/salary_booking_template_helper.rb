module SalaryBookingTemplateHelper
  def saldo_inclusion_flag_collection
    SalaryBookingTemplate.saldo_inclusion_flags.map{|flag| [t_attr('saldo_inclusion_flags.' + flag), flag]}
  end
end
