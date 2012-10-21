require "spec_helper"

describe DeliverabilitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/deliverabilities").should route_to("deliverabilities#index")
    end

    it "routes to #new" do
      get("/deliverabilities/new").should route_to("deliverabilities#new")
    end

    it "routes to #show" do
      get("/deliverabilities/1").should route_to("deliverabilities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deliverabilities/1/edit").should route_to("deliverabilities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deliverabilities").should route_to("deliverabilities#create")
    end

    it "routes to #update" do
      put("/deliverabilities/1").should route_to("deliverabilities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deliverabilities/1").should route_to("deliverabilities#destroy", :id => "1")
    end

  end
end
