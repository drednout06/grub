require 'spec_helper'

describe "districts/index" do
  before(:each) do
    assign(:districts, [
      stub_model(District),
      stub_model(District)
    ])
  end

  it "renders a list of districts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
