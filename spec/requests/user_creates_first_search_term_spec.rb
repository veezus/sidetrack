require 'spec_helper'

Feature "User creates first search term" do
  Scenario "success" do
    let(:user) { User.last }
    let(:search_term) { user.search_terms.last }
    let(:term) { 'veezus' }

    When "I visit the home page" do
      visit root_path
    end

    Then "I see my claim code" do
      page.should have_content(user.claim_code)
    end

    When "I enter a search term" do
      fill_in "Term", :with => term
      click_button 'Create Search term'
    end

    Then "I am taken to the dashboard" do
      current_path.should == dashboard_path
    end

    And "I see a success message" do
      page.should have_content("Successfully created search term")
    end

    And "I see the search term" do
      page.should have_css("a[href='#{search_term_path(search_term)}']", :text => term)
    end
  end
end
