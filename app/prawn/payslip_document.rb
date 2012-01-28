class PayslipDocument < LetterDocument
  def salary_table(salary)
    head = [
      t_attr(:code, LineItem),
      t_attr(:title, LineItem),
      t_attr(:price, LineItem),
      t_attr(:times, LineItem),
      t_attr(:accounted_amount, LineItem)
    ]
    content = salary.line_items.collect do |item|
      [item.code, item.title, currency_fmt(item.price), item.times, currency_fmt(item.accounted_amount)]
    end

    rows = [head] + content

    table(rows, :width => bounds.width) do
      # General cell styling
      cells.valign  = :top
      cells.borders = []
      cells.padding_bottom = 2
      cells.padding_top = 2

      # Columns
      columns(2..4).align = :right

      # Footer styling
      row(-1).font_style = :bold
    end
  end
end
