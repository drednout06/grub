require 'spec_helper'

describe "districts/show" do
  before(:each) do
    @district = assign(:district, stub_model(District))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
