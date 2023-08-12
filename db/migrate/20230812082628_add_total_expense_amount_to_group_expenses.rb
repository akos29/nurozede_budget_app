class AddTotalExpenseAmountToGroupExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :group_expenses, :total_expense_amount, :decimal
  end
end
