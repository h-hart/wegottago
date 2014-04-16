ActiveAdmin.register ThemeCategory do
  index do
    column :name
    column :created_at
    column :updated_at
    
    actions :defaults => false do |tc|
      link_to 'View', admin_theme_category_path(tc)
    end
    actions :defaults => false do |tc|
      link_to 'Edit', edit_admin_theme_category_path(tc)
    end
    actions :defaults => false do |tc|
      link_to 'Delete', admin_theme_category_path(tc), method: :delete, data: { confirm: 'All Activities within this category will be also removed. Are you sure you wan to remove it ?' }
    end
  end

  controller do
    def scoped_collection
      # Hide users uniquer category
      ThemeCategory.where('id != 50000')
    end
  end
end
