require 'rails_helper'

RSpec.describe "Quest routes", type: :routing do
  describe "RESTful routes" do
    it "routes to #index" do
      expect(get: "/quests").to route_to("quests#index")
    end

    it "routes to #create" do
      expect(post: "/quests").to route_to("quests#create")
    end

    it "routes to #destroy" do
      expect(delete: "/quests/1").to route_to("quests#destroy", id: "1")
    end
  end

  describe "custom routes" do
    it "routes to #toggle" do
      expect(patch: "/quests/1/toggle").to route_to("quests#toggle", id: "1")
    end
  end

  describe "route helpers" do
    it "generates correct path for quests_path" do
      expect(quests_path).to eq("/quests")
    end

    it "generates correct path for quest_path" do
      expect(quest_path(1)).to eq("/quests/1")
    end

    it "generates correct path for toggle_quest_path" do
      expect(toggle_quest_path(1)).to eq("/quests/1/toggle")
    end
  end

  describe "HTTP methods" do
    it "accepts GET for index" do
      expect(get: quests_path).to be_routable
    end

    it "accepts POST for create" do
      expect(post: quests_path).to be_routable
    end

    it "accepts DELETE for destroy" do
      expect(delete: quest_path(1)).to be_routable
    end

    it "accepts PATCH for toggle" do
      expect(patch: toggle_quest_path(1)).to be_routable
    end

    it "does not accept PUT for toggle" do
      expect(put: "/quests/1/toggle").not_to be_routable
    end

    it "does not accept GET for create" do
      expect(get: "/quests/create").not_to be_routable
    end
  end

  describe "nested routes" do
    it "correctly handles quest ID parameter" do
      expect(patch: "/quests/123/toggle").to route_to(
        controller: "quests",
        action: "toggle",
        id: "123"
      )
    end

    it "correctly handles quest ID parameter for destroy" do
      expect(delete: "/quests/456").to route_to(
        controller: "quests",
        action: "destroy",
        id: "456"
      )
    end
  end
end
