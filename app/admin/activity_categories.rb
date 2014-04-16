ActiveAdmin.register ActivityCategory do
  form partial: 'form'

  index do
    column :id
    column :name
    column(:wide_image){ |obj| image_tag(obj.wide_image_url, :height => '100') if obj.wide_image_url }
    column(:small_image){ |obj| image_tag(obj.small_image_url, :height => '100') if obj.small_image_url }
    column(:interest_list)
    default_actions
  end

  show do
    attributes_table do
      row :name
      row(:wide_image){ |obj| image_tag(obj.wide_image_url, :height => '100') if obj.wide_image.url }
      row(:small_image){ |obj| image_tag(obj.small_image_url, :height => '100') if obj.small_image_url }
      row(:interest_list)
    end
  end

  filter :name

end
