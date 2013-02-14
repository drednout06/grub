require 'spec_helper'

describe "invoices/index" do
  before(:each) do
    assign(:invoices, [
      stub_model(Invoice,
        :user_id => 1,
        :comment => "Comment",
        :sum => "9.99",
        :status => "Status"
      ),
      stub_model(Invoice,
        :user_id => 1,
        :comment => "Comment",
        :sum => "9.99",
        :status => "Status"
      )
    ])
  end

  it "renders a list of invoices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
