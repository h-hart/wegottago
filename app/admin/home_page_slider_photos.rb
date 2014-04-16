ActiveAdmin.register HomePageSliderPhotos do
  index do
    column (:image) { |obj| image_tag(obj.image.url, :height => '100') }
    column :caption
    default_actions
  end

  show do
    attributes_table do
      row (:image) { |obj| image_tag(obj.image.url, :height => '100') }
      row :caption
    end
  end
  
end
