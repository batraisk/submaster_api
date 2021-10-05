ActiveAdmin.register Faq, as: "FAQ" do
  menu :label => "FAQ"
  permit_params :question, :answer
  before_filter :skip_sidebar!, :only => :index

  index do
    selectable_column
    id_column
    column :answer
    column :question
    actions
  end

  filter :answer
  filter :created_at

  form do |f|
    f.inputs do
      f.input :question
      # f.input :answer, as: :quill_editor
      f.input :answer, as: :quill_editor, input_html: { data:
                                                        { options:
                                                            { modules:
                                                                { toolbar:
                                                                    [%w[bold italic underline strike],
                                                                     %w[blockquote code-block],
                                                                     [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                                                                     [{ 'align': [] }],
                                                                     ['link'],
                                                                     [{ 'size': ['small', false, 'large', 'huge'] }],
                                                                     [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                                                     [{ 'indent': '-1' }, { 'indent': '+1' }],
                                                                     [{ 'direction': 'rtl' }],
                                                                     [{ 'color': [] }, { 'background': [] }],
                                                                     [{ 'font': [] }],
                                                                     ['clean'],
                                                                     ['image'],
                                                                     ['video']] },
                                                              theme: 'snow' } } }
      # f.input :published
    end
    f.actions
  end

end
