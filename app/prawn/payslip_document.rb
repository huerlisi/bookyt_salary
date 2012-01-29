class PayslipDocument < LetterDocument
  def salary_table(salary)
    head = [
      t_attr(:code, LineItem),
      t_attr(:title, LineItem),
      t_attr(:times, LineItem),
      t_attr(:price, LineItem),
      t_attr(:accounted_amount, LineItem)
    ]

    rows = []
    saldo_rows = []
    salary.line_items.each_with_index do |item, index|
      if item.quantity == "saldo_of"
        saldo_rows << index + 1
        rows << [item.code, item.title, nil, nil, currency_fmt(item.price)]
      else
        rows << [item.code, item.title, item.times_to_s, currency_fmt(item.price), currency_fmt(item.accounted_amount)]
      end
    end

    rows = [head] + rows

    table(rows, :width => bounds.width) do
      # General cell styling
      cells.valign  = :top
      cells.borders = []
      cells.padding_bottom = 2
      cells.padding_top = 2
      columns(0).padding_left = 0

      # Columns
      columns(2..4).align = :right

      # Saldo styling
      saldo_rows.each do |index|
        row(index).font_style = :bold
        row(index).padding_bottom = 10
      end

      # Header styling
      row(0).font_style  = :bold
    end
  end
end
