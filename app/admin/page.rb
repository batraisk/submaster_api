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

  show do
    panel "Graphs" do
      line_chart Page.group_by_day(:created_at).count
      # column_chart [["2016-01-01", 30], ["2016-02-01", 54]], stacked: true, library: {colors: ["#D80A5B", "#21C8A9", "#F39C12", "#A4C400"]}

    end
  end

  form do |f|
    f.inputs do
      f.input :page_name
    end
    f.actions
  end

end
