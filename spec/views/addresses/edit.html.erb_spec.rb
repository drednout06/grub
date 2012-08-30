require 'spec_helper'

describe "addresses/edit" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :city => "MyString",
      :district => "MyString",
      :house => "MyString",
      :porch => "MyString",
      :floor => "MyString",
      :doorphone => "MyString",
      :comment => "MyString"
    ))
  end

  it "renders the edit address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => addresses_path(@address), :method => "post" do
      assert_select "input#address_city", :name => "address[city]"
      assert_select "input#address_district", :name => "address[district]"
      assert_select "input#address_house", :name => "address[house]"
      assert_select "input#address_porch", :name => "address[porch]"
      assert_select "input#address_floor", :name => "address[floor]"
      assert_select "input#address_doorphone", :name => "address[doorphone]"
      assert_select "input#address_comment", :name => "address[comment]"
    end
  end
end
