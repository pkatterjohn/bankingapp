class ChangeNullTransactionAcctToAcctFrom < ActiveRecord::Migration
  def change
   change_column_null :transactions, :acct_to, true
   change_column_null :transactions, :acct_from, true
  end
end
