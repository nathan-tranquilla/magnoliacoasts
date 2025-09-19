require "spec_helper"

PAGES = [
	{
		url: "/investment/maternity",
		h1: "Maternity Packages",
		prev: "/investment/collections",
		prev_h1: "Collections Packages",
		next: "/investment/newborn",
		next_h1: "Newborn Packages"
	},
	{
		url: "/investment/newborn",
		h1: "Newborn Packages",
		prev: "/investment/maternity",
		prev_h1: "Maternity Packages",
		next: "/investment/milestone",
		next_h1: "Milestone Packages"
	},
	{
		url: "/investment/milestone",
		h1: "Milestone Packages",
		prev: "/investment/newborn",
		prev_h1: "Newborn Packages",
		next: "/investment/family",
		next_h1: "Family Packages"
	},
	{
		url: "/investment/family",
		h1: "Family Packages",
		prev: "/investment/milestone",
		prev_h1: "Milestone Packages",
		next: "/investment/headshot",
		next_h1: "Headshot, Branding & Portrait"
	},
	{
		url: "/investment/headshot",
		h1: "Headshot, Branding & Portrait",
		prev: "/investment/family",
		prev_h1: "Family Packages",
		next: "/investment/collections",
		next_h1: "Collections Packages"
	},
	{
		url: "/investment/collections",
		h1: "Collections Packages",
		prev: "/investment/headshot",
		prev_h1: "Headshot, Branding & Portrait",
		next: "/investment/maternity",
		next_h1: "Maternity Packages"
	}
]

[:cuprite, :cuprite_mobile].each do |driver|
	RSpec.describe "investment sibling navigation with \\#{driver}", type: :feature, driver: driver, cross_links: true do
		before { Capybara.current_driver = driver }
		after  { Capybara.use_default_driver }

		PAGES.each do |test_case|
			it "navigates forward from \\#{test_case[:url]} to next page and checks h1" do
				visit test_case[:url]
        find("a#next").trigger("click")
        expect(page).to have_current_path(test_case[:next], ignore_query: true)
        expect(page).to have_selector("h1", text: test_case[:next_h1])
			end

			it "navigates backward from \\#{test_case[:url]} to previous page and checks h1" do
				visit test_case[:url]
        find("a#prev").trigger("click")
        expect(page).to have_current_path(test_case[:prev], ignore_query: true)
        expect(page).to have_selector("h1", text: test_case[:prev_h1])
			end
		end
	end
end
