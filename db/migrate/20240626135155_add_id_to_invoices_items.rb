class AddIdToInvoicesItems < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices_items, :id, :primary_key
  end
end
