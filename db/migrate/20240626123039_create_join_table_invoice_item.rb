class CreateJoinTableInvoiceItem < ActiveRecord::Migration[7.1]
  def change
    create_join_table :invoices, :items do |t|
      # t.index [:invoice_id, :item_id]
      # t.index [:item_id, :invoice_id]
			t.string :quantity
			t.integer :unit_price
			t.integer :status

			t.timestamps
    end
  end
end
