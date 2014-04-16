ActiveAdmin.register Page do
  actions :all, except: [:new, :destroy]

  index do
    column :id
    column :name
    column(:text){|obj| obj.text.try(:html_safe) }
    default_actions
  end

  show do
    attributes_table do
      row :name
      row(:text){|obj| obj.text.try(:html_safe) }
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :text, :as => :ckeditor
    end
    f.actions
  end

  filter :name
end
