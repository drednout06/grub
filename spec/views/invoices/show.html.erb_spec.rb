require 'spec_helper'

describe "invoices/show" do
  before(:each) do
    @invoice = assign(:invoice, stub_model(Invoice,
      :user_id => 1,
      :comment => "Comment",
      :sum => "9.99",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Comment/)
    rendered.should match(/9.99/)
    rendered.should match(/Status/)
  end
end
