class AddParametersToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :acct_from, :integer, null: false
    add_column :transactions, :acct_to, :integer, null: false
    add_column :transactions, :transfer_amount, :float, null: false
  end
end
