prawn_document(:filename => "#{resource.to_s}.pdf", :renderer => Prawn::LetterDocument) do |pdf|
  employer = resource.employer
  employee = resource.employee
  direct_account = Account.find_by_code("5000")
  direct_bookings = Booking.by_reference(resource)
  direct_balance = direct_bookings.empty? ? 0.0 : direct_bookings.direct_balance(direct_account)
  
  # Letter header
  pdf.letter_header(employer, employee, resource.to_s)
  
  # Free text with the socical security number
  pdf.free_text "#{t_attr(:social_security_nr, Employee)}: #{employee.social_security_nr}"
  
  # Line Items
  pdf.salary_table(direct_balance, direct_account, direct_bookings)
  
  # Closing
  pdf.common_closing(employer) 
end