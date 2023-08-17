class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
