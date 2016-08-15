# encoding: UTF-8

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
  {:code => "5800", :title => "Übriger Personalaufwand", :account_type => costs},
])

# Booking Templates
BookingTemplate.create!([
  {:code => "salary:invoice", :title => "Monatslohn", :credit_account => Account.find_by_code("2050"), :debit_account => Account.find_by_code("5000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "salary:cancel", :title => "Storno", :credit_account => Account.find_by_code("5000"), :debit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "salary:cash_payment", :title => "Barzahlung Lohn", :credit_account => Account.find_by_code("1000"), :debit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "salary:bank_payment", :title => "Bankzahlung Lohn", :credit_account => Account.find_by_code("1020"), :debit_account => Account.find_by_code("2050")},
])

# SalaryBookingTemplates
SalaryBookingTemplate.create!([
  {:code => '1000', :title => 'Monatslohn', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1005', :title => 'Stundenlohn', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1061', :title => 'Überstunden 125%', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1073', :title => 'Sonntagszulage', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1100', :title => 'Baustellenzulage', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1160', :title => 'Ferienvergütung', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1161', :title => 'Feiertagsentschädigung', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1200', :title => '13. Monatslohn', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1201', :title => 'Gratifikation', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '3', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1202', :title => 'Weihnachtszulage', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '3', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1300', :title => 'Lohn bei Unfall', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1301', :title => 'Lohn bei Krankheit', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1302', :title => 'Lohn bei Militärdienst/Zivilschutz', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1303', :title => 'Lohn bei Aus- und Weiterbildung', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1900', :title => 'Gratisverpflegung', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '2.1', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1910', :title => 'Privatanteil Geschäftswagen', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '2.2', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '1980', :title => 'Weiterbildung (Lohnausweis)', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '13.3', :include_in_saldo_list => 'Bruttolohn, AHV, UVG, UVGZ, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '2000', :title => 'EO-Taggeld', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '2035', :title => 'Kranken-Taggeld', :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '2040', :title => 'Mutterschaftsentschädigung', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, AHV, KTG, Quellensteuer, Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '3000', :title => 'Kinderzulage', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5000'), :salary_declaration_code => '1', :include_in_saldo_list => 'Bruttolohn, Quellensteuer, Nettolohn', :amount => '300', :amount_relates_to => ''},
  {:code => '5000', :title => 'Bruttolohn', :salary_declaration_code => '', :include_in_saldo_list => '', :amount => '', :amount_relates_to => 'Bruttolohn'},
  {:code => '5010', :title => 'AHV-Beitrag', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '9', :include_in_saldo_list => 'Nettolohn', :amount => '5.15%', :amount_relates_to => 'AHV'},
  {:code => '5020', :title => 'ALV-Beitrag', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '9', :include_in_saldo_list => 'Quellensteuer, Nettolohn', :amount => '1.1%', :amount_relates_to => 'AHV'},
  {:code => '5030', :title => 'ALVZ-Beitrag', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '9', :include_in_saldo_list => 'Nettolohn', :amount => '0.5%', :amount_relates_to => 'AHV'},
  {:code => '5040', :title => 'NBUV-Beitrag', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '9', :include_in_saldo_list => 'Nettolohn', :amount => '0.71%', :amount_relates_to => 'AHV'},
  {:code => '5041', :title => 'UVGZ-Beitrag A1', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => 'UVG'},
  {:code => '5042', :title => 'UVGZ-Beitrag A2', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => 'UVG'},
  {:code => '5045', :title => 'KTG-Beitrag A1', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => 'KTG'},
  {:code => '5046', :title => 'KTG-Beitrag A2', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => 'KTG'},
  {:code => '5048', :title => 'KTG-Beitrag B1', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => 'KTG'},
  {:code => '5050', :title => 'BVG-Beitrag', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '10.1', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '5051', :title => 'BVG-Einkaufs-Beiträge', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '10.2', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '5060', :title => 'Quellensteuerabzug', :credit_account => Account.find_by_code('5000'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '12', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '6000', :title => 'Reisespesen', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5800'), :salary_declaration_code => '13.1.1', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '6001', :title => 'Autospesen', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5800'), :salary_declaration_code => '13.1.1', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '6002', :title => 'Verpflegungsspesen', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5800'), :salary_declaration_code => '13.1.1', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '6070', :title => 'Übrige Pauschalspesen', :credit_account => Account.find_by_code('2050'), :debit_account => Account.find_by_code('5800'), :salary_declaration_code => '13.2.3', :include_in_saldo_list => 'Nettolohn', :amount => '', :amount_relates_to => ''},
  {:code => '6500', :title => 'Nettolohn', :salary_declaration_code => '', :include_in_saldo_list => 'Auszahlung', :amount => '', :amount_relates_to => 'Nettolohn'},
  {:code => '6510', :title => 'Vorauszahlung', :credit_account => Account.find_by_code('1020'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => 'Auszahlung', :amount => '', :amount_relates_to => ''},
  {:code => '6600', :title => 'Auszahlung', :credit_account => Account.find_by_code('1020'), :debit_account => Account.find_by_code('2050'), :salary_declaration_code => '', :include_in_saldo_list => '', :amount => '', :amount_relates_to => 'Auszahlung'},
])

# SalaryTemplate
SalaryTemplate.create!([
  {
    :title => "Allgemeine Vorlage Monatslohn",
    :salary_items => SalaryItem.create!([
      {:position => 1, :salary_booking_template => SalaryBookingTemplate.find_by_code('1000')},
      {:position => 2, :salary_booking_template => SalaryBookingTemplate.find_by_code('3000')},
      {:position => 3, :salary_booking_template => SalaryBookingTemplate.find_by_code('5000')},
      {:position => 4, :salary_booking_template => SalaryBookingTemplate.find_by_code('5010')},
      {:position => 5, :salary_booking_template => SalaryBookingTemplate.find_by_code('5020')},
      {:position => 6, :salary_booking_template => SalaryBookingTemplate.find_by_code('5030')},
      {:position => 7, :salary_booking_template => SalaryBookingTemplate.find_by_code('5040')},
      {:position => 8, :salary_booking_template => SalaryBookingTemplate.find_by_code('5041')},
      {:position => 9, :salary_booking_template => SalaryBookingTemplate.find_by_code('5045')},
      {:position => 10, :salary_booking_template => SalaryBookingTemplate.find_by_code('5050')},
      {:position => 11, :salary_booking_template => SalaryBookingTemplate.find_by_code('6500')},
      {:position => 12, :salary_booking_template => SalaryBookingTemplate.find_by_code('6600')},
    ])
  },
  {
    :title => "Allgemeine Vorlage für Stundenlohn",
    :salary_items => SalaryItem.create!([
      {:position => 1, :salary_booking_template => SalaryBookingTemplate.find_by_code('1005')},
      {:position => 2, :salary_booking_template => SalaryBookingTemplate.find_by_code('3000')},
      {:position => 3, :salary_booking_template => SalaryBookingTemplate.find_by_code('5000')},
      {:position => 4, :salary_booking_template => SalaryBookingTemplate.find_by_code('5010')},
      {:position => 5, :salary_booking_template => SalaryBookingTemplate.find_by_code('5020')},
      {:position => 6, :salary_booking_template => SalaryBookingTemplate.find_by_code('5030')},
      {:position => 7, :salary_booking_template => SalaryBookingTemplate.find_by_code('5040')},
      {:position => 8, :salary_booking_template => SalaryBookingTemplate.find_by_code('5041')},
      {:position => 9, :salary_booking_template => SalaryBookingTemplate.find_by_code('5045')},
      {:position => 10, :salary_booking_template => SalaryBookingTemplate.find_by_code('5050')},
      {:position => 11, :salary_booking_template => SalaryBookingTemplate.find_by_code('6500')},
      {:position => 12, :salary_booking_template => SalaryBookingTemplate.find_by_code('6600')},
    ])
  },
])
