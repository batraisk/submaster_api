class AddReferenceToUtmTage < ActiveRecord::Migration[6.1]
  def change
    add_reference :utm_tags, :guest, foreign_key: true
  end
end
