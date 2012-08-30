require 'spec_helper'

describe "addresses/show" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :city => "City",
      :district => "District",
      :house => "House",
      :porch => "Porch",
      :floor => "Floor",
      :doorphone => "Doorphone",
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    rendered.should match(/District/)
    rendered.should match(/House/)
    rendered.should match(/Porch/)
    rendered.should match(/Floor/)
    rendered.should match(/Doorphone/)
    rendered.should match(/Comment/)
  end
end
