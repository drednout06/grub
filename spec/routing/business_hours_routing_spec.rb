require "spec_helper"

describe BusinessHoursController do
  describe "routing" do

    it "routes to #index" do
      get("/business_hours").should route_to("business_hours#index")
    end

    it "routes to #new" do
      get("/business_hours/new").should route_to("business_hours#new")
    end

    it "routes to #show" do
      get("/business_hours/1").should route_to("business_hours#show", :id => "1")
    end

    it "routes to #edit" do
      get("/business_hours/1/edit").should route_to("business_hours#edit", :id => "1")
    end

    it "routes to #create" do
      post("/business_hours").should route_to("business_hours#create")
    end

    it "routes to #update" do
      put("/business_hours/1").should route_to("business_hours#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/business_hours/1").should route_to("business_hours#destroy", :id => "1")
    end

  end
end
