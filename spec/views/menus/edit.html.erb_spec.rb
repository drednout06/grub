require 'spec_helper'

describe "menus/edit" do
  before(:each) do
    @menu = assign(:menu, stub_model(Menu,
      :name => "MyString",
      :restaurant_id => 1
    ))
  end

  it "renders the edit menu form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menus_path(@menu), :method => "post" do
      assert_select "input#menu_name", :name => "menu[name]"
      assert_select "input#menu_restaurant_id", :name => "menu[restaurant_id]"
    end
  end
end
