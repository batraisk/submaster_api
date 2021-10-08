ActiveAdmin.register Promocode do
  permit_params :code, :kind, :begins_at, :ends_at, :duration, :amount

  controller do
    def destroy
      @promocode = Promocode.find(params[:id])
      @promocode.users.present? ? @promocode.discard : @promocode.destroy
      redirect_to :admin_promocodes
    end
  end
  index do
    selectable_column
    id_column
    column I18n.t("attribute.promocode.code"), :code
    column I18n.t("attribute.promocode.begins_at"), :begins_at
    column I18n.t("attribute.promocode.ends_at"), :ends_at
    column I18n.t("attribute.promocode.amount"), :amount
    actions
  end

  filter :code
  filter :begins_at, as: :date_time_range
  filter :ends_at, as: :date_time_range

  form do |f|
    f.inputs do
      f.input :code, label: I18n.t("attribute.promocode.code")
      # f.input :kind,
      #         as: :radio,
      #         label: 'Type',
      #         collection: [["Currency", :currency, { checked: 'checked' }], ["Period", :time_period]],
      #         value: :add
      f.input :begins_at, label: I18n.t("attribute.promocode.begins_at"), as: :date_time_picker, input_html: { autocomplete: :off }
      f.input :ends_at, label: I18n.t("attribute.promocode.ends_at"), as: :date_time_picker, input_html: { autocomplete: :off }
      # f.input :duration, label: 'Duration in days'
      f.input :amount,
              as: :number,
              label: I18n.t("attribute.promocode.amount_in_rub"),
              required: false, input_html: { value: 0.0 }
    end
    f.actions
  end

end
