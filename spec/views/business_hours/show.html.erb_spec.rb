require 'spec_helper'

describe "business_hours/show" do
  before(:each) do
    @business_hour = assign(:business_hour, stub_model(BusinessHour,
      :restaurant_id => 1,
      :schedule => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
