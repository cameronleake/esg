class AddErrorCodesToOrderTransactions < ActiveRecord::Migration
  def change
    add_column :order_transactions, :error_codes, :integer
  end
end
