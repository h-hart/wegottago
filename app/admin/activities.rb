ActiveAdmin.register Activity do
  index do
    column :id
    column (:image) { |obj| image_tag(obj.theme.image.url, :height => '100') }
    column :title
    column :location
    column :details
    default_actions
  end

  show do
    attributes_table do
      row :title
      row :location
      row :personal_quote
      row :details
    end
  end

  filter :title
  filter :location

  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :personal_quote
      f.input :details
    end
    f.actions
  end

end





