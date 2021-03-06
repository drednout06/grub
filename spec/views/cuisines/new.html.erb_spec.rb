require 'spec_helper'

describe "cuisines/new" do
  before(:each) do
    assign(:cuisine, stub_model(Cuisine,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new cuisine form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cuisines_path, :method => "post" do
      assert_select "input#cuisine_name", :name => "cuisine[name]"
    end
  end
end
