require "spec_helper"

describe UserFavoritesController do
  describe "routing" do

    it "routes to #index" do
      get("/user_favorites").should route_to("user_favorites#index")
    end

    it "routes to #new" do
      get("/user_favorites/new").should route_to("user_favorites#new")
    end

    it "routes to #show" do
      get("/user_favorites/1").should route_to("user_favorites#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_favorites/1/edit").should route_to("user_favorites#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_favorites").should route_to("user_favorites#create")
    end

    it "routes to #update" do
      put("/user_favorites/1").should route_to("user_favorites#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_favorites/1").should route_to("user_favorites#destroy", :id => "1")
    end

  end
end
