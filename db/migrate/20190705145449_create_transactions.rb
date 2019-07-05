class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.string :transaction_type, null: false

      t.timestamps null: false
    end
  end
end
