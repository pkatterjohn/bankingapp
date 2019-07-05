class AddNameToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :name, :string, null: false
  end
end
