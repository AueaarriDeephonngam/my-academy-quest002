Feature: Quest Management
  As a user
  I want to manage my quests
  So that I can track my daily tasks and goals

  Background:
    Given I am on the quest management page

  Scenario: View empty quest list
    When I visit the quest page with no existing quests
    Then I should see "No quests yet!"
    And I should see "Add your first quest above to get started"
    And I should see the add quest form

  Scenario: Add a new quest
    When I fill in the quest title with "Learn Cucumber testing"
    And I click the add quest button
    Then I should see "Learn Cucumber testing" in the quest list
    And I should see "1 quest" in the quest count

  @javascript
  Scenario: Mark quest as completed
    Given I have a quest titled "Complete the project"
    When I check the checkbox for "Complete the project"
    Then the quest "Complete the project" should be marked as completed
    And I should see "1 completed" in the quest count

  @javascript
  Scenario: Mark completed quest as incomplete
    Given I have a completed quest titled "Finished task"
    When I uncheck the checkbox for "Finished task"
    Then the quest "Finished task" should be marked as incomplete
    And I should see "0 completed" in the quest count

  @javascript
  Scenario: Delete a quest
    Given I have a quest titled "Task to be deleted"
    When I click the delete button for "Task to be deleted"
    Then I should not see "Task to be deleted" in the quest list

  Scenario: View multiple quests in correct order
    Given I have the following quests:
      | title           | created_at      | done  |
      | Oldest quest    | 3 days ago      | false |
      | Middle quest    | 1 day ago       | true  |
      | Newest quest    | 1 hour ago      | false |
    When I visit the quest page
    Then I should see quests in the following order:
      | Newest quest  |
      | Middle quest  |
      | Oldest quest  |
    And I should see "3 quests" in the quest count
    And I should see "1 completed" in the quest count

  Scenario: Add quest with invalid data
    When I try to add a quest with empty title
    Then the quest should not be created
    And I should remain on the quest page

  Scenario: Navigate to brag document
    When I click on "My brag document" button
    Then I should be on the brag document page

  @javascript
  Scenario: Add quest dynamically without page refresh
    When I fill in the quest title with "Dynamic quest"
    And I click the add quest button
    Then I should see "Dynamic quest" in the quest list immediately
    And the quest form should be cleared
    And the page should not have refreshed

  @javascript
  Scenario: Toggle quest status dynamically
    Given I have a quest titled "Toggle me"
    When I check the checkbox for "Toggle me"
    Then the quest "Toggle me" should be visually marked as completed immediately
    And the quest count should update immediately

  @javascript  
  Scenario: Delete quest dynamically
    Given I have a quest titled "Delete me now"
    When I click the delete button for "Delete me now"
    Then the quest "Delete me now" should disappear immediately
    And the quest count should update immediately

  Scenario: Quest persistence across page refreshes
    Given I have added a quest titled "Persistent quest"
    When I refresh the page
    Then I should still see "Persistent quest" in the quest list
    And the quest count should remain accurate
