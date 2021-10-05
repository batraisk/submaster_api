class AddOnlineCourseLinkToApplicationSetting < ActiveRecord::Migration[6.1]
  def change
    add_column :application_settings, :online_course_link, :string, default: ''
  end
end
