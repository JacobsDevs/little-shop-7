class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.integer :status

      t.timestamps
    end
  end
end
