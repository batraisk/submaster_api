class CreateDomains < ActiveRecord::Migration[6.1]
  def change
    create_table :domains do |t|
      t.string :url

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
