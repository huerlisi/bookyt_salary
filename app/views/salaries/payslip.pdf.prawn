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

  unless resource.employment.hourly_paid
    pdf.move_down 20
    pdf.text "Stundenabrechnung", :style => :bold
    pdf.text "#{t_attr(:hours_due, Activity)}: #{@hours_due}"
    pdf.text "#{t_attr(:hours_worked, Activity)}: #{@hours_worked}"
    pdf.text " "
    pdf.text "Aktueller Stundensaldo: #{@hours_saldo}"
  end

  # Closing
  pdf.common_closing(employer) 
end
