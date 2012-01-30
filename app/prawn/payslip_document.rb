class PayslipDocument < LetterDocument
  def salary_table(salary)
    rows = []
    saldo_rows = []
    salary.line_items.each_with_index do |item, index|
      if item.quantity == "saldo_of"
        saldo_rows << index
        rows << [item.title, nil, nil, currency_fmt(item.price)]
      else
        rows << [item.title, item.times_to_s, currency_fmt(item.price), currency_fmt(item.accounted_amount)]
      end
    end

    table(rows, :width => bounds.width) do
      # General cell styling
      cells.valign  = :top
      cells.borders = []
      cells.padding_bottom = 2
      cells.padding_top = 2
      columns(0).padding_left = 0

      # Columns
      columns(1..3).align = :right

      # Saldo styling
      saldo_rows.each do |index|
        row(index).font_style = :bold
        row(index).padding_bottom = 10
      end
    end
  end
end
