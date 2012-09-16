require 'spec_helper'

describe "cuisines/index" do
  before(:each) do
    assign(:cuisines, [
      stub_model(Cuisine,
        :name => "Name"
      ),
      stub_model(Cuisine,
        :name => "Name"
      )
    ])
  end

  it "renders a list of cuisines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
