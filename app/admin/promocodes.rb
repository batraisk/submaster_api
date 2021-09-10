ActiveAdmin.register Promocode do
  permit_params :code, :kind, :begins_at, :ends_at, :duration, :amount

  index do
    selectable_column
    id_column
    column :code
    column :kind
    column :begins_at
    column :ends_at
    column :duration
    column :amount
    actions
  end

  filter :code
  filter :kind
  filter :begins_at, as: :date_time_range
  filter :ends_at, as: :date_time_range

  form do |f|
    f.inputs do
      f.input :code
      f.input :kind,
              as: :radio,
              label: 'Type',
              collection: [["Currency", :currency, { checked: 'checked' }], ["Period", :time_period]],
              value: :add
      f.input :begins_at, as: :date_time_picker
      f.input :ends_at, as: :date_time_picker
      f.input :duration, label: 'Duration in days'
      f.input :amount,
              as: :number,
              label: 'Amount in ruble',
              required: false, input_html: { value: 0.0 }
    end
    f.actions
  end

end
