class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :account_type, null: false
      t.float :amount, null: false

      t.timestamps null: false
    end
  end
end
