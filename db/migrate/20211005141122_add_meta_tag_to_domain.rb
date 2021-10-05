class AddMetaTagToDomain < ActiveRecord::Migration[6.1]
  def change
    add_column :domains, :meta_tag, :string, default: ''
  end
end
