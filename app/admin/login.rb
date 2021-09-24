ActiveAdmin.register Login do
  # permit_params :question, :answer
  #
  # index do
  #   selectable_column
  #   id_column
  #   column :question
  #   actions
  # end
  #
  # filter :pages
  # filter :created_at
  filter :name
  filter :status
  filter :pages_page_name, :as => :select, :collection => Page.all.collect {|o| [o.page_name]}, label: 'Page'

  #
  # form do |f|
  #   f.inputs do
  #     f.input :question
  #     f.input :answer, as: :quill_editor
  #   end
  #   f.actions
  # end

end
