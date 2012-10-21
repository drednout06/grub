require 'spec_helper'

describe "business_hours/new" do
  before(:each) do
    assign(:business_hour, stub_model(BusinessHour,
      :restaurant_id => 1,
      :schedule => "MyText"
    ).as_new_record)
  end

  it "renders new business_hour form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => business_hours_path, :method => "post" do
      assert_select "input#business_hour_restaurant_id", :name => "business_hour[restaurant_id]"
      assert_select "textarea#business_hour_schedule", :name => "business_hour[schedule]"
    end
  end
end
