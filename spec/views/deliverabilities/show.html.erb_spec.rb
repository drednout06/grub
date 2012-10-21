require 'spec_helper'

describe "deliverabilities/show" do
  before(:each) do
    @deliverability = assign(:deliverability, stub_model(Deliverability))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
