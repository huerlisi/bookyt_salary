prawn_document(:filename => "#{resource.to_s}.pdf", :renderer => PayslipDocument) do |pdf|
  employer = resource.employer
  employee = resource.employee
  
  # Letter header
  pdf.letter_header(employer, employee, resource.to_s)
  
  # Free text with the socical security number
  
  # Line Items
  pdf.salary_table(resource)

  pdf.move_down 20
  pdf.text "#{t_attr(:social_security_nr, Employee)}: #{employee.social_security_nr}"
  pdf.text "#{t_attr(:payment_to, Employment)}: #{resource.employment.payment_to}"

  # Closing
  pdf.common_closing(employer) 
end
