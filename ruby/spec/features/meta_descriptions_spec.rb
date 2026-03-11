require "spec_helper"

# Test cases for unique meta descriptions across the entire website
page_descriptions = [
  # Main pages
  {
    path: "/",
    expected: "Magnolia Coasts Photography in Mississauga"
  },
  {
    path: "/about",
    expected: "Meet Stephanie, the photographer behind Magnolia Coasts"
  },
  {
    path: "/gallery",
    expected: "Browse photography galleries by Magnolia Coasts"
  },
  {
    path: "/investment",
    expected: "View photography packages and pricing"
  },

  # Gallery pages
  {
    path: "/gallery/maternity",
    expected: "Maternity photography gallery"
  },
  {
    path: "/gallery/newborn",
    expected: "Newborn photography gallery"
  },
  {
    path: "/gallery/family",
    expected: "Family photography gallery"
  },
  {
    path: "/gallery/children",
    expected: "Children's photography gallery"
  },
  {
    path: "/gallery/milestones",
    expected: "Milestone photography gallery"
  },
  {
    path: "/gallery/headshots",
    expected: "Headshot photography gallery"
  },
  {
    path: "/gallery/branding",
    expected: "Branding photography gallery"
  },
  {
    path: "/gallery/cakesmash",
    expected: "Cake smash and birthday photography gallery"
  },

  # Investment pages
  {
    path: "/investment/maternity",
    expected: "Maternity photography packages and pricing"
  },
  {
    path: "/investment/newborn",
    expected: "Newborn photography packages and pricing"
  },
  {
    path: "/investment/family",
    expected: "Family photography packages and pricing"
  },
  {
    path: "/investment/milestone",
    expected: "Milestone photography packages and pricing"
  },
  {
    path: "/investment/headshot",
    expected: "Headshot, branding, and portrait packages"
  },
  {
    path: "/investment/collections",
    expected: "Photography collection packages"
  }
]

[:cuprite].each do |driver|
  RSpec.describe "(#{driver}) meta descriptions", type: :feature, driver: driver, seo: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    page_descriptions.each do |test_case|
      it "has unique description for #{test_case[:path]}" do
        visit test_case[:path]

        meta = find('meta[name="description"]', visible: false)
        content = meta[:content]

        # Description exists and is not empty
        expect(content).not_to be_empty

        # Contains expected unique content
        expect(content).to include(test_case[:expected]),
          "Expected description for #{test_case[:path]} to include '#{test_case[:expected]}', got '#{content}'"

        # Description includes Mississauga
        expect(content.downcase).to include("mississauga"),
          "Description for #{test_case[:path]} should mention Mississauga"

        # SEO best practice: 50-160 characters
        expect(content.length).to be <= 160,
          "Description for #{test_case[:path]} is #{content.length} chars, should be ≤160"
        expect(content.length).to be >= 50,
          "Description for #{test_case[:path]} is #{content.length} chars, should be ≥50"
      end
    end

    it "has unique descriptions across all pages" do
      descriptions = page_descriptions.map do |test_case|
        visit test_case[:path]
        find('meta[name="description"]', visible: false)[:content]
      end

      # All descriptions should be unique
      expect(descriptions.uniq.length).to eq(descriptions.length),
        "Found duplicate descriptions: #{descriptions.group_by(&:itself).select { |_, v| v.length > 1 }.keys}"
    end

    it "has matching og:description on all pages" do
      page_descriptions.each do |test_case|
        visit test_case[:path]

        meta_desc = find('meta[name="description"]', visible: false)[:content]
        og_desc = find('meta[property="og:description"]', visible: false)[:content]

        expect(og_desc).to eq(meta_desc),
          "og:description doesn't match meta description on #{test_case[:path]}"
      end
    end
  end
end
