require "spec_helper"

GALLERIES = [
  { url: "/gallery/maternity", h1: "Maternity", },
  { url: "/gallery/newborn", h1: "Newborn", },
  { url: "/gallery/milestones", h1: "Milestone", },
  { url: "/gallery/cakesmash", h1: "Cake Smash", },
  { url: "/gallery/family", h1: "Family", },
  { url: "/gallery/children", h1: "Children", },
  { url: "/gallery/branding", h1: "Branding", },
  { url: "/gallery/headshots", h1: "Headshots", }
]

def gallery_nav_cases(galleries)
  galleries.each_with_index.map do |gallery, i|
    prev_i = (i - 1) % galleries.length
    next_i = (i + 1) % galleries.length
    {
      url: gallery[:url],
      h1: gallery[:h1],
      prev: galleries[prev_i][:url],
      prev_h1: galleries[prev_i][:h1],
      next: galleries[next_i][:url],
      next_h1: galleries[next_i][:h1]
    }
  end
end

PAGES = gallery_nav_cases(GALLERIES)

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "gallery sibling navigation with ", type: :feature, driver: driver, cross_links: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    PAGES.each do |test_case|
      it "navigates forward from #{test_case[:url]} to next gallery and checks h1" do
        visit test_case[:url]
        find("a#next").trigger("click")
        expect(page).to have_current_path(test_case[:next], ignore_query: true)
        expect(page).to have_selector("h1", text: test_case[:next_h1])
      end

      it "navigates backward from #{test_case[:url]} to previous gallery and checks h1" do
        visit test_case[:url]
        find("a#prev").trigger("click")
        expect(page).to have_current_path(test_case[:prev], ignore_query: true)
        expect(page).to have_selector("h1", text: test_case[:prev_h1])
      end
    end
  end
end
