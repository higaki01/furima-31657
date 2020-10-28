class RenameAdressColumnToAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :adress, :address 
  end
end
