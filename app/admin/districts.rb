ActiveAdmin.register District do
  index do
  	column :id
    column :name
    column :city_id
    column :created_at
    column :updated_at
    default_actions
  end
end
