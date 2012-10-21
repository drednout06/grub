require 'spec_helper'

describe "deliverabilities/edit" do
  before(:each) do
    @deliverability = assign(:deliverability, stub_model(Deliverability))
  end

  it "renders the edit deliverability form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deliverabilities_path(@deliverability), :method => "post" do
    end
  end
end
