class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :transactions, :account_id, :user_id
  end
end
