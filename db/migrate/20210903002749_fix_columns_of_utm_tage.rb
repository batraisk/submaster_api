class FixColumnsOfUtmTage < ActiveRecord::Migration[6.1]
  def change
    rename_column :utm_tags, :content, :utm_content
    rename_column :utm_tags, :campaign, :utm_campaign
    rename_column :utm_tags, :medium, :utm_medium
    rename_column :utm_tags, :source, :utm_source

    remove_column :utm_tags, :subscriptions
    remove_column :utm_tags, :conversion
    remove_column :utm_tags, :clicks
  end
end
