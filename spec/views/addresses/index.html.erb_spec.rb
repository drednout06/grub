require 'spec_helper'

describe "addresses/index" do
  before(:each) do
    assign(:addresses, [
      stub_model(Address,
        :city => "City",
        :district => "District",
        :house => "House",
        :porch => "Porch",
        :floor => "Floor",
        :doorphone => "Doorphone",
        :comment => "Comment"
      ),
      stub_model(Address,
        :city => "City",
        :district => "District",
        :house => "House",
        :porch => "Porch",
        :floor => "Floor",
        :doorphone => "Doorphone",
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "District".to_s, :count => 2
    assert_select "tr>td", :text => "House".to_s, :count => 2
    assert_select "tr>td", :text => "Porch".to_s, :count => 2
    assert_select "tr>td", :text => "Floor".to_s, :count => 2
    assert_select "tr>td", :text => "Doorphone".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
