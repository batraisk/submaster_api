ActiveAdmin.register Page do
  permit_params :page_name

  index do
    selectable_column
    id_column
    column :page_name
    actions
  end

  filter :page_name
  filter :created_at

  # show do
  #   panel "Graphs" do
  #     line_chart Page.group_by_day(:created_at).count
  #
  #   end
  # end
  show do
    tabs do
      @stats = Statistics::Admin::Page.new(resource)
      tab :details do
        attributes_table do
          row :id
          row :download_link
          row :facebook_server_side_token
          row :instagram_login
          row :out_of_stock_description
          row :out_of_stock_title
          row :page_name
          row :status
          row :success_button_text
          row :success_description
          row :success_title
          row :theme
          row :timer_enable
          row :timer_text
          row :timer_time
          row :url
          row :welcome_button_text
          row :welcome_description
          row :welcome_title
          row :yandex_metrika
          row :youtube
          row :created_at
          row :updated_at
          row :facebook_pixel_id
        end
      end
      tab :statistics do
        panel "Clicks" do
          render partial: "admin/pages/statistics/page_stats", locals: { stats: @stats.clicks[:data] }
        end
        panel "Subscribers" do
          render partial: "admin/pages/statistics/page_stats", locals: { stats: @stats.subscribers[:data] }
        end
        panel "Ctr" do
          render partial: "admin/pages/statistics/page_stats", locals: { stats: @stats.ctr[:data] }
        end

      end
      tab 'Visits' do
        paginated_collection(resource.guests.order(created_at: :desc).page(params[:page]).per(15), download_links: false) do
          table_for(collection, sortable: false) do
            column :created_at
            column :status
          end
        end
      end
    end
  end
end
