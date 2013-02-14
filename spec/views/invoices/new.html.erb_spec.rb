require 'spec_helper'

describe "invoices/new" do
  before(:each) do
    assign(:invoice, stub_model(Invoice,
      :user_id => 1,
      :comment => "MyString",
      :sum => "9.99",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new invoice form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invoices_path, :method => "post" do
      assert_select "input#invoice_user_id", :name => "invoice[user_id]"
      assert_select "input#invoice_comment", :name => "invoice[comment]"
      assert_select "input#invoice_sum", :name => "invoice[sum]"
      assert_select "input#invoice_status", :name => "invoice[status]"
    end
  end
end
