ActiveAdmin.register Payment do
  permit_params :amount

  index do
    selectable_column
    id_column
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
    column :order_id
    column :user_id
    column :actions
  end

  filter :user_id
  filter :created_at

  # form do |f|
  #   f.inputs do
  #     f.input :question
  #     f.input :answer, as: :quill_editor
  #   end
  #   f.actions
  # end

end
