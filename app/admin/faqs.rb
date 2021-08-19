ActiveAdmin.register Faq do
  permit_params :question, :answer

  index do
    selectable_column
    id_column
    column :question
    actions
  end

  filter :answer
  filter :created_at

  form do |f|
    f.inputs do
      f.input :question
      f.input :answer, as: :froala_editor
    end
    f.actions
  end

end
