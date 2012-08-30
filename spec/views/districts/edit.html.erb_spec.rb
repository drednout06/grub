require 'spec_helper'

describe "districts/edit" do
  before(:each) do
    @district = assign(:district, stub_model(District))
  end

  it "renders the edit district form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => districts_path(@district), :method => "post" do
    end
  end
end
