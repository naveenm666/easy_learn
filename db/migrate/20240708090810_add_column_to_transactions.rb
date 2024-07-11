class AddColumnToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :payment_id, :string
    add_column :transactions, :status, :string
  end
end
