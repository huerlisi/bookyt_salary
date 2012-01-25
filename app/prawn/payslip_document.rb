class PayslipDocument < LetterDocument
  def salary_table(direct_balance, direct_account, direct_bookings)
    content = direct_bookings.inject([]) do |out, item|
      title = item.title if item
      out << [title, nil, nil, nil, currency_fmt(item.accounted_amount(direct_account))] if item.contra_account(direct_account)

      out
    end

    rows = content + [total_row(currency_fmt(direct_balance))]

    items_table(rows)
  end
end
