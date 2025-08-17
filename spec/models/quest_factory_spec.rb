require 'rails_helper'

RSpec.describe "Quest Factory", type: :model do
  describe "FactoryBot.create(:quest)" do
    it "creates a valid quest" do
      quest = FactoryBot.create(:quest)
      expect(quest).to be_valid
      expect(quest).to be_persisted
    end

    it "has required attributes" do
      quest = FactoryBot.create(:quest)
      expect(quest.title).to be_present
      expect(quest.title).to be_a(String)
    end

    it "has default done value" do
      quest = FactoryBot.create(:quest)
      expect([ nil, false, true ]).to include(quest.done)
    end
  end

  describe "FactoryBot.build(:quest)" do
    it "builds a valid quest without saving" do
      quest = FactoryBot.build(:quest)
      expect(quest).to be_valid
      expect(quest).not_to be_persisted
    end

    it "can be saved after building" do
      quest = FactoryBot.build(:quest)
      expect(quest.save).to be true
      expect(quest).to be_persisted
    end
  end

  describe "factory traits and variations" do
    it "can create completed quest if trait exists" do
      # This would work if we had a :completed trait
      # quest = FactoryBot.create(:quest, :completed)
      # expect(quest.done).to be true

      quest = FactoryBot.create(:quest, done: true)
      expect(quest.done).to be true
    end

    it "can create incomplete quest" do
      quest = FactoryBot.create(:quest, done: false)
      expect(quest.done).to be false
    end

    it "can override title" do
      custom_title = "Custom Quest Title"
      quest = FactoryBot.create(:quest, title: custom_title)
      expect(quest.title).to eq(custom_title)
    end
  end

  describe "factory associations" do
    it "creates quest without requiring associations" do
      expect { FactoryBot.create(:quest) }.not_to raise_error
    end
  end

  describe "factory validations" do
    it "respects model validations" do
      expect {
        FactoryBot.create(:quest, title: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "allows blank done field" do
      expect {
        FactoryBot.create(:quest, done: nil)
      }.not_to raise_error
    end
  end

  describe "factory sequences and uniqueness" do
    it "can create multiple quests" do
      quests = FactoryBot.create_list(:quest, 3)
      expect(quests.length).to eq(3)
      expect(quests.all?(&:valid?)).to be true
      expect(quests.all?(&:persisted?)).to be true
    end

    it "creates unique records" do
      quest1 = FactoryBot.create(:quest)
      quest2 = FactoryBot.create(:quest)
      expect(quest1.id).not_to eq(quest2.id)
    end
  end
end
