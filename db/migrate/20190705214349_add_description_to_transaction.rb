class AddDescriptionToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :description, :string
    change_column_null :transactions, :acct_to, true
  end
end
