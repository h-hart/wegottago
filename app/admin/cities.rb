ActiveAdmin.register City do
  index do
    column :id
    column :name
    column :loc_lat
    column :loc_lng
    column(:image){ |obj| image_tag(obj.image.url, :height => '100') }
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :loc_lat
      row :loc_lng
      row(:image){ |obj| image_tag(obj.image.url, :height => '100') }
    end
  end

  filter :name
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Admin Details" do
      f.input :name, :hint => "<div id='gl-map' style ='width: 77.3%; height: 200px;'></div>".html_safe
      f.input :loc_lat, as: :hidden
      f.input :loc_lng, as: :hidden
      f.input :image, as: :file, :hint => f.template.image_tag(f.object.image_url)
    end
    f.actions
  end
  
end
