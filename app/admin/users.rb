ActiveAdmin.register User do
  permit_params :email

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  filter :email

  show do
    tabs do
      tab 'Details' do
        attributes_table do
          row :id
          row :email
          row :confirmed_at
          row :created_at
          row('Balance') { |b| b.balance }
        end
      end
      tab 'Pages' do
        table_for user.pages do
          column :page_name do |page|
            link_to page.page_name, admin_page_path(page)
          end
        end
      end
      tab 'Payments' do
        table_for user.payments do
          column :amount
          column :card_bin
          column :card_type
          column :currency
          column :fee
          column :masked_card
          column :order_status
          column :order_time
          column :reversal_amount
          column :sender_account
          column :sender_cell_phone
          column :sender_email
          column :settlement_amount
          column :signature
          column :created_at
        end
      end
      tab 'Promocodes' do
        table_for user.promocodes do
          column :code
          column :created_at
          column :amount
        end
      end
    end
  end
  
end
