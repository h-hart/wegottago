ActiveAdmin.register Theme do
  index do
    column (:id)
    column (:theme_category_id) {|obj| obj.theme_category.name }
    column (:image) { |obj| image_tag(obj.image.url, :height => '100') }

    actions :defaults => false do |t|
      link_to 'View', admin_theme_path(t)
    end
    actions :defaults => false do |t|
      link_to 'Edit', edit_admin_theme_path(t)
    end
    actions :defaults => false do |t|
      link_to 'Delete', admin_theme_path(t), method: :delete, data: { confirm: 'All Activities within this category will be also removed. Are you sure you wan to remove it ?' }
    end
  end

  show do
    attributes_table do
      row (:theme_category_id) {|obj| obj.theme_category.name }
      row (:image) { |obj| image_tag(obj.image.url, :height => '100') }
    end
  end  
end
