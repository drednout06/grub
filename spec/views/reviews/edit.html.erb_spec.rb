require 'spec_helper'

describe "reviews/edit" do
  before(:each) do
    @review = assign(:review, stub_model(Review,
      :user_id => 1,
      :restaurant_id => 1,
      :content => "MyText"
    ))
  end

  it "renders the edit review form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reviews_path(@review), :method => "post" do
      assert_select "input#review_user_id", :name => "review[user_id]"
      assert_select "input#review_restaurant_id", :name => "review[restaurant_id]"
      assert_select "textarea#review_content", :name => "review[content]"
    end
  end
end
