require "rails_helper"

RSpec.describe PortfoliosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/portfolios").to route_to("portfolios#index")
    end

    it "routes to #new" do
      expect(get: "/portfolios/new").to route_to("portfolios#new")
    end

    it "routes to #show" do
      expect(get: "/portfolios/1").to route_to("portfolios#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/portfolios/1/edit").to route_to("portfolios#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/portfolios").to route_to("portfolios#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/portfolios/1").to route_to("portfolios#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/portfolios/1").to route_to("portfolios#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/portfolios/1").to route_to("portfolios#destroy", id: "1")
    end
  end
end
