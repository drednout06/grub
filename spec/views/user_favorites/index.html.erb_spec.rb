require 'spec_helper'

describe "user_favorites/index" do
  before(:each) do
    assign(:user_favorites, [
      stub_model(UserFavorite,
        :user_id => 1,
        :restaurant_id => 2
      ),
      stub_model(UserFavorite,
        :user_id => 1,
        :restaurant_id => 2
      )
    ])
  end

  it "renders a list of user_favorites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
