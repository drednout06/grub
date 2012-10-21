require 'spec_helper'

describe "business_hours/edit" do
  before(:each) do
    @business_hour = assign(:business_hour, stub_model(BusinessHour,
      :restaurant_id => 1,
      :schedule => "MyText"
    ))
  end

  it "renders the edit business_hour form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => business_hours_path(@business_hour), :method => "post" do
      assert_select "input#business_hour_restaurant_id", :name => "business_hour[restaurant_id]"
      assert_select "textarea#business_hour_schedule", :name => "business_hour[schedule]"
    end
  end
end
