class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :password, null: false
      t.integer :admin, null: false
      t.belongs_to :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
