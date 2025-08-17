require 'rails_helper'

RSpec.describe "quests/index", type: :view do
  let(:quest1) { Quest.create!(title: "First quest", done: false) }
  let(:quest2) { Quest.create!(title: "Second quest", done: true) }

  before(:each) do
    assign(:quest, Quest.new)
  end

  context "when quests exist" do
    before(:each) do
      assign(:quests, Quest.where(id: [quest1.id, quest2.id]))
      render
    end

    it "displays the quest application container" do
      expect(rendered).to have_selector('.quest-app-container')
      expect(rendered).to have_selector('.quest-card')
    end

    it "displays the profile section" do
      expect(rendered).to have_selector('.profile-section')
      expect(rendered).to have_selector('h1', text: 'Auearee Deephonngam')
      expect(rendered).to have_selector('.profile-image img')
    end

    it "displays quest count" do
      expect(rendered).to have_selector('#quest-count')
      expect(rendered).to include('quest')
      expect(rendered).to include('completed')
    end

    it "renders the add quest form" do
      expect(rendered).to have_selector('form.add-quest-form')
      expect(rendered).to have_selector('input[name="quest[title]"]')
      expect(rendered).to have_selector('button[type="submit"]')
      expect(rendered).to have_selector('input[placeholder="Add new quest..."]')
    end

    it "renders the quest list section" do
      expect(rendered).to have_selector('.quest-list')
      expect(rendered).to have_selector('#quest-list')
    end

    it "displays individual quests" do
      expect(rendered).to include(quest1.title)
      expect(rendered).to include(quest2.title)
    end

    it "includes the brag document button" do
      expect(rendered).to have_link('My brag document', href: '/brag_document')
      expect(rendered).to have_selector('a.brag-btn')
    end

    it "includes FontAwesome icons" do
      expect(rendered).to have_selector('i.fas')
    end
  end

  context "when no quests exist" do
    before(:each) do
      assign(:quests, Quest.none)
      render
    end

    it "still displays the basic structure" do
      expect(rendered).to have_selector('.quest-app-container')
      expect(rendered).to have_selector('.add-quest-section')
      expect(rendered).to have_selector('form.add-quest-form')
    end

    it "displays empty state in quest count" do
      expect(rendered).to have_selector('#quest-count')
      expect(rendered).to include('Ready to start your quest journey!')
    end

    it "renders the add quest form for new quests" do
      expect(rendered).to have_selector('input[name="quest[title]"]')
      expect(rendered).to have_selector('button[type="submit"]')
    end
  end

  describe "form attributes" do
    before(:each) do
      assign(:quests, Quest.none)
      render
    end

    it "has correct form attributes for Turbo" do
      expect(rendered).to have_selector('form[data-turbo="true"]')
      expect(rendered).to have_selector('form[data-remote="true"]')
      expect(rendered).to have_selector('form[action="/quests"]')
      expect(rendered).to have_selector('form[method="post"]')
    end

    it "has required input field" do
      expect(rendered).to have_selector('input[required="required"]')
      expect(rendered).to have_selector('input[type="text"]')
    end

    it "has submit button with icon" do
      expect(rendered).to have_selector('button.add-btn')
      expect(rendered).to have_selector('button i.fa-plus')
    end
  end

  describe "CSS classes and styling" do
    before(:each) do
      assign(:quests, Quest.where(id: quest1.id))
      render
    end

    it "has correct CSS classes for styling" do
      expect(rendered).to have_selector('.quest-app-container')
      expect(rendered).to have_selector('.quest-card')
      expect(rendered).to have_selector('.header')
      expect(rendered).to have_selector('.add-quest-section')
      expect(rendered).to have_selector('.quest-list')
      expect(rendered).to have_selector('.input-group')
      expect(rendered).to have_selector('.add-quest-input')
      expect(rendered).to have_selector('.add-btn')
    end

    it "includes brag button with correct classes" do
      expect(rendered).to have_selector('a.btn.btn-primary.brag-btn')
    end
  end

  describe "accessibility" do
    before(:each) do
      assign(:quests, Quest.where(id: quest1.id))
      render
    end

    it "has appropriate input labels and placeholders" do
      expect(rendered).to have_selector('input[placeholder="Add new quest..."]')
    end

    it "has button titles for accessibility" do
      expect(rendered).to have_selector('button[title="Add Quest"]')
    end

    it "has proper form structure" do
      expect(rendered).to have_selector('form input[name="quest[title]"]')
      expect(rendered).to have_selector('form button[type="submit"]')
    end
  end
end
