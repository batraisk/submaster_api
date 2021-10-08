class AddDiscardedAtToPromocodes < ActiveRecord::Migration[6.1]
  def change
    add_column :promocodes, :discarded_at, :datetime
    add_index :promocodes, :discarded_at
  end
end
