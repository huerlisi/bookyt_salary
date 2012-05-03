class AddLeaveDayColumnsToSalaries < ActiveRecord::Migration
  def change
    add_column :invoices, :unused_leave_days, :decimal
  end
end
