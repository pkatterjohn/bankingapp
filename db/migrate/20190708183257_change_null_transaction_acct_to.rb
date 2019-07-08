class ChangeNullTransactionAcctTo < ActiveRecord::Migration
  def change
    change_column_null :transactions, :acct_to, false
  end
end
