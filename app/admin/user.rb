ActiveAdmin.register User do

  index do
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :admin
    column :restaurateur
    column :created_at
  end

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :restaurateur, :label => "Restaurateur"
      f.input :admin, :label => "Administrator"
    end
    f.buttons
  end

  create_or_edit = Proc.new {
    @user = User.find_or_create_by_id(params[:id])
    @user.admin = params[:user][:admin]
    @user.attributes = params[:user].delete_if do |k, v| 
      (k == "admin") ||
      (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

end