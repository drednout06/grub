require 'spec_helper'

describe "user_favorites/edit" do
  before(:each) do
    @user_favorite = assign(:user_favorite, stub_model(UserFavorite,
      :user_id => 1,
      :restaurant_id => 1
    ))
  end

  it "renders the edit user_favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_favorites_path(@user_favorite), :method => "post" do
      assert_select "input#user_favorite_user_id", :name => "user_favorite[user_id]"
      assert_select "input#user_favorite_restaurant_id", :name => "user_favorite[restaurant_id]"
    end
  end
end
