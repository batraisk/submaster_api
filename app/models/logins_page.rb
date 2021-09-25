# == Schema Information
#
# Table name: logins_pages
#
#  login_id :bigint           not null
#  page_id  :bigint           not null
#
# Indexes
#
#  index_logins_pages_on_login_id  (login_id)
#  index_logins_pages_on_page_id   (page_id)
#
class LoginsPage < ApplicationRecord
  belongs_to :login
  belongs_to :page
end
