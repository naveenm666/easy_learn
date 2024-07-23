class AddColumnsToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :expires_at, :datetime
    add_column :transactions, :notified, :boolean, default: false
  end
end
