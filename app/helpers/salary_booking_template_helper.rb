module SalaryBookingTemplateHelper
  def saldo_inclusion_flag_collection
    SalaryBookingTemplate.saldo_inclusion_flags.map{|flag| [t('activerecord.attributes.salary_booking_template.saldo_inclusion_flags.' + flag), flag]}
  end

  def amount_relates_to_collection
    saldo_inclusion_flags = SalaryBookingTemplate.saldo_inclusion_flags.map{|flag| [t('activerecord.attributes.salary_booking_template.saldo_inclusion_flags.' + flag), flag]}
    booking_templates = SalaryBookingTemplate.all.map{|template| [template.to_s, template.code]}

    return saldo_inclusion_flags + booking_templates
  end
end
