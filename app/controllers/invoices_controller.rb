class InvoicesController < InheritedResources::Base
	before_filter :authenticate_user!
  load_and_authorize_resource

  def new
  	@user = User.find(params[:user_id])
  	new!
	end

end
