class CreateUtmTags < ActiveRecord::Migration[6.1]
  def change
    create_table :utm_tags do |t|
      t.string :source
      t.string :medium
      t.string :campaign
      t.string :content
      t.integer :clicks
      t.integer :subscriptions
      t.integer :conversion
      t.references :page, index: true, foreign_key: true

      t.timestamps
    end
  end
end
