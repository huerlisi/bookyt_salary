# Salaries
# ========
outside_capital = AccountType.find_by_name('outside_capital')
costs           = AccountType.find_by_name('costs')

# Accounts
Account.create!([
  {:code => "2020", :title => "Kreditoren Sozialversicherungen", :account_type => outside_capital},
  {:code => "2050", :title => "Offene Lohnforderungen", :account_type => outside_capital},
  {:code => "5000", :title => "Lohnaufwand", :account_type => costs},
  {:code => "5700", :title => "Sozialversicherungaufwand", :account_type => costs},
])

# Booking Templates
BookingTemplate.create!([
  {:code => "salary:invoice", :title => "Monatslohn", :debit_account => Account.find_by_code("2050"), :credit_account => Account.find_by_code("5000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "salary:cancel", :title => "Storno", :debit_account => Account.find_by_code("5000"), :credit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "salary:cash_payment", :title => "Barzahlung Lohn", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "salary:bank_payment", :title => "Bankzahlung Lohn", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2050")},
])

# Charge Rates
ChargeRate.create!([
  {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2007-01-01', :rate => 5.05},
  {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2011-01-01', :rate => 5.15},

  {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2007-01-01', :rate => 1},
  {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2011-01-01', :rate => 1.1},

  {:code => 'salary:both:alv_solidarity', :title => "ALV Solidaritätsprozent", :duration_from => '2011-01-01', :rate => 1},

  {:code => 'salary:employer:bu', :title => "BU", :duration_from => '2007-01-01', :duration_to => '2014-01-01', :rate => 0.071},

  {:code => 'salary:employee:nbu', :title => "NBU", :duration_from => '2010-07-01', :duration_to => '2014-01-01', :rate => 0.951},
  {:code => 'salary:employer:nbu', :title => "NBU", :duration_from => '2010-07-01', :duration_to => '2014-01-01', :rate => 0},

  {:code => 'salary:employer:fak', :title => "FAK", :duration_from => '2007-01-01', :rate => 1.6},
  {:code => 'salary:employer:fak', :title => "FAK", :duration_from => '2010-01-01', :rate => 1.4},

  {:code => 'salary:employer:vkb', :title => "VKB", :duration_from => '2007-01-01', :rate => 3 * 0.101},
  {:code => 'salary:employer:vkb', :title => "VKB", :duration_from => '2011-01-01', :rate => 3 * 0.13},
])

ChargeBookingTemplate.create!([
  {:code => "salary:employee:ahv_iv_eo", :charge_rate_code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("2050"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:ahv_iv_eo", :charge_rate_code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employee:alv", :charge_rate_code => 'salary:both:alv', :title => "ALV Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("2050"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:alv", :charge_rate_code => 'salary:both:alv', :title => "ALV Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employer:bu", :charge_rate_code => 'salary:employer:bu', :title => "BU Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employee:nbu", :charge_rate_code => 'salary:employee:nbu', :title => "NBU Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("2050"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:nbu", :charge_rate_code => 'salary:employer:nbu', :title => "NBU Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employer:fak", :charge_rate_code => 'salary:employer:fak', :title => "FAK Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employer:vkb", :charge_rate_code => 'salary:employer:vkb', :title => "VKB Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},
])
