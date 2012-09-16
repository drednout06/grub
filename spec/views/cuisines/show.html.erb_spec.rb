require 'spec_helper'

describe "cuisines/show" do
  before(:each) do
    @cuisine = assign(:cuisine, stub_model(Cuisine,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
