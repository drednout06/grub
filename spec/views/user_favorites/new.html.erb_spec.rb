require 'spec_helper'

describe "user_favorites/new" do
  before(:each) do
    assign(:user_favorite, stub_model(UserFavorite,
      :user_id => 1,
      :restaurant_id => 1
    ).as_new_record)
  end

  it "renders new user_favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_favorites_path, :method => "post" do
      assert_select "input#user_favorite_user_id", :name => "user_favorite[user_id]"
      assert_select "input#user_favorite_restaurant_id", :name => "user_favorite[restaurant_id]"
    end
  end
end
