class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :status
      t.references :page, index: true, foreign_key: true
      t.timestamps
    end
  end
end
