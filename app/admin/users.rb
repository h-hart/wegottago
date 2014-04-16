ActiveAdmin.register User do
  actions :all, except: [:edit]
  index do
    column :id
    column(:registered_with) do |obj|
      if obj.uid
        'Facebook'
      else
        'Email'
      end
    end
    column :name
    column :last_name
    column :email
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :last_name
      row :email
    end
  end

  filter :name
  filter :last_name
  filter :email
  
end
