class CreateUserInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :user_infos do |t|
      t.string :locale
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
