prawn_document(:filename => "#{resource.to_s}.pdf", :renderer => PayslipDocument) do |pdf|
  employer = resource.employer
  employee = resource.employee
  
  # Letter header
  pdf.letter_header(employer, employee, resource.to_s)
  
  # Line Items
  pdf.salary_table(resource)

  pdf.move_down 20
  rows = [
    [t_attr(:social_security_nr, Employee), employee.social_security_nr],
    [t_attr(:payment_to, Employment), resource.employment.payment_to]
  ]
  pdf.table rows, :width => pdf.bounds.width do
    cells.valign  = :top
    cells.borders = []
    cells.padding_bottom = 2
    cells.padding_top = 2

    columns(0).padding_left = 0
    columns(0).width = 5.cm
  end

  unless resource.employment.hourly_paid
    pdf.move_down 20
    pdf.text "Stundenabrechnung", :style => :bold

    month_name          = t('date.month_names')[@salary.duration_from.month]
    rows = [
      ["Übertrag Vormonat", "%0.2f" % @hours_carry],
      ["#{t_attr(:hours_due, Activity)} #{month_name}", "%0.2f" % @hours_due],
      ["#{t_attr(:hours_worked, Activity)} #{month_name}", "%0.2f" % @hours_worked],
      ["Aktueller Stundensaldo", "%0.2f" % @hours_saldo],
    ]

    pdf.table rows, :width => (pdf.bounds.width * 0.4) do
      cells.valign  = :top
      cells.borders = []
      cells.padding_bottom = 2
      cells.padding_top = 2

      columns(0).padding_left = 0
      columns(0).width = 5.cm
      columns(1).align = :right

      rows(3).font_style = :bold
    end
  end

  # Free text with the socical security number
  pdf.free_text(resource.text)

  # Closing
  pdf.common_closing(employer) 
end
