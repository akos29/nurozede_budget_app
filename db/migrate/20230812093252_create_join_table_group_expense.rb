class CreateJoinTableGroupExpense < ActiveRecord::Migration[7.0]
  def change
    create_join_table :groups, :expenses do |t|
      t.index [:group_id, :expense_id]
      t.index [:expense_id, :group_id]
      t.decimal :total_expense_amount
    end
  end
end
