class AddGroupTotalToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :group_total, :decimal, default: 0.0
  end
end
