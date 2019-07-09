class AdjustTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :user_id
    add_reference :transactions, :user, foreign_key: true
  end
end
