require 'spec_helper'

describe "cuisines/edit" do
  before(:each) do
    @cuisine = assign(:cuisine, stub_model(Cuisine,
      :name => "MyString"
    ))
  end

  it "renders the edit cuisine form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cuisines_path(@cuisine), :method => "post" do
      assert_select "input#cuisine_name", :name => "cuisine[name]"
    end
  end
end
