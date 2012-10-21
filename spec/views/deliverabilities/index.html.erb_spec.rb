require 'spec_helper'

describe "deliverabilities/index" do
  before(:each) do
    assign(:deliverabilities, [
      stub_model(Deliverability),
      stub_model(Deliverability)
    ])
  end

  it "renders a list of deliverabilities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
