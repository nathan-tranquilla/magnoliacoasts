require "spec_helper"

# Test cases for page titles across the entire website
page_titles = [
  # Main pages
  {
    path: "/",
    expected_title: "Magnolia Coasts | Toronto Family & Maternity Photography"
  },
  {
    path: "/about",
    expected_title: "Magnolia Coasts | Toronto and GTA Photographer"
  },
  {
    path: "/gallery",
    expected_title: "Magnolia Coasts | Toronto | Photography Gallery"
  },
  {
    path: "/investment",
    expected_title: "Magnolia Coasts | Toronto | Photography Investment"
  },

  # Gallery pages (using Gallery layout with metaTitle pattern)
  {
    path: "/gallery/maternity",
    expected_title: "Magnolia Coasts | Toronto | Maternity Photos"
  },
  {
    path: "/gallery/newborn",
    expected_title: "Magnolia Coasts | Toronto | Newborn Photos"
  },
  {
    path: "/gallery/family",
    expected_title: "Magnolia Coasts | Toronto | Family Photos"
  },
  {
    path: "/gallery/children",
    expected_title: "Magnolia Coasts | Toronto | Children's Photos"
  },
  {
    path: "/gallery/milestones",
    expected_title: "Magnolia Coasts | Toronto | Milestone Photos"
  },
  {
    path: "/gallery/headshots",
    expected_title: "Magnolia Coasts | Toronto | Headshot Photos"
  },
  {
    path: "/gallery/branding",
    expected_title: "Magnolia Coasts | Toronto | Branding Photos"
  },
  {
    path: "/gallery/cakesmash",
    expected_title: "Magnolia Coasts | Toronto | Cake Smash Photos"
  },

  # Investment pages (using InvestmentPackage layout with title pattern)
  {
    path: "/investment/maternity",
    expected_title: "Magnolia Coasts | Toronto | Maternity Packages"
  },
  {
    path: "/investment/newborn",
    expected_title: "Magnolia Coasts | Toronto | Newborn Packages"
  },
  {
    path: "/investment/family",
    expected_title: "Magnolia Coasts | Toronto | Family Packages"
  },
  {
    path: "/investment/milestone",
    expected_title: "Magnolia Coasts | Toronto | Milestone Packages"
  },
  {
    path: "/investment/headshot",
    expected_title: "Magnolia Coasts | Toronto | Headshot, Branding & Portrait"
  },
  {
    path: "/investment/collections",
    expected_title: "Magnolia Coasts | Toronto | Collections Packages"
  }
]

[:cuprite].each do |driver|
  RSpec.describe "(#{driver}) page titles", type: :feature, driver: driver, seo: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    # Additional test to ensure no pages have empty or default titles
    page_titles.each do |test_case|
      it "is optimized for seo #{test_case[:path]}" do
        visit test_case[:path]

        # Wait for page to load completely
        expect(page).to have_css('title', visible: false)
        
        # Check the title matches exactly
        expect(page).to have_title(test_case[:expected_title])
        
        actual_title = page.title
        
        # Ensure title is not empty
        expect(actual_title).not_to be_empty
        expect(actual_title).not_to be_nil
        
        # Ensure title is not just generic defaults
        expect(actual_title).not_to eq("Untitled")
        expect(actual_title).not_to eq("Document")
        expect(actual_title).not_to eq("New Tab")
        
        # Ensure it contains the site name
        expect(actual_title).to include("Magnolia Coasts")
        expect(actual_title).to include("Toronto")
        # Check title length is 60 characters or less for optimal SEO
        # puts actual_title.length
        expect(actual_title.length).to be <= 60, 
          "Title '#{actual_title}' is #{actual_title.length} characters, should be ≤60 for SEO"
      end
    end

  end
end