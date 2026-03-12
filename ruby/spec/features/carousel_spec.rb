require "spec_helper"
require "support/constants"

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "(#{driver}) carousel", type: :feature, driver: driver, testimonials: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

      def assert_visible_review(review_titles, visible_index)
        review_titles.each_with_index do |title, i|
          if i == visible_index
            expect(page).to have_selector(".testimonials .carousel-item:not(.opacity-0) .card", text: title, visible: :all)
          else
            expect(page).to have_selector(".testimonials .carousel-item.opacity-0 .card", text: title, visible: :all)
          end
        end
      end

      xit "works" do
        visit "/"
        review_titles = ["Erika McNabb", "Nritya Bhumi Studio", "Tisha McNama"]

        assert_visible_review(review_titles, 0)

        find("button#carousel-go-right", visible: :all).click
        assert_visible_review(review_titles, 1)

        find("button#carousel-go-right", visible: :all).click
        assert_visible_review(review_titles, 2)

        # End of carousel — stays on last
        find("button#carousel-go-right", visible: :all).click
        assert_visible_review(review_titles, 2)

        find("button#carousel-go-left", visible: :all).click
        assert_visible_review(review_titles, 1)

        find("button#carousel-go-left", visible: :all).click
        assert_visible_review(review_titles, 0)

        # Start of carousel — stays on first
        find("button#carousel-go-left", visible: :all).click
        assert_visible_review(review_titles, 0)
      end
  end
end
