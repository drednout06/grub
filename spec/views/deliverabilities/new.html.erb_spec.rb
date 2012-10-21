require 'spec_helper'

describe "deliverabilities/new" do
  before(:each) do
    assign(:deliverability, stub_model(Deliverability).as_new_record)
  end

  it "renders new deliverability form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deliverabilities_path, :method => "post" do
    end
  end
end
