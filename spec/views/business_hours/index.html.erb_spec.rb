require 'spec_helper'

describe "business_hours/index" do
  before(:each) do
    assign(:business_hours, [
      stub_model(BusinessHour,
        :restaurant_id => 1,
        :schedule => "MyText"
      ),
      stub_model(BusinessHour,
        :restaurant_id => 1,
        :schedule => "MyText"
      )
    ])
  end

  it "renders a list of business_hours" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
