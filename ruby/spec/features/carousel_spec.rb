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

      def click_carousel_button(id)
        # Use execute_script to avoid ObsoleteNode errors from React
        # hydration replacing server-rendered DOM nodes
        page.execute_script("document.getElementById('#{id}').click()")
      end

      it "works" do
        visit "/"
        review_titles = ["Erika McNabb", "Nritya Bhumi Studio", "Tisha McNama"]

        # Initial: Erika McNabb
        assert_visible_review(review_titles, 0)

        # Click right: Nritya
        click_carousel_button('carousel-go-right')
        assert_visible_review(review_titles, 1)

        # Click right: Tisha
        click_carousel_button('carousel-go-right')
        assert_visible_review(review_titles, 2)

        # Click right: Still Tisha (end of carousel)
        click_carousel_button('carousel-go-right')
        assert_visible_review(review_titles, 2)

        # Go backwards
        click_carousel_button('carousel-go-left')
        assert_visible_review(review_titles, 1)

        click_carousel_button('carousel-go-left')
        assert_visible_review(review_titles, 0)

        # Clicking left again should still show Erika (start of carousel)
        click_carousel_button('carousel-go-left')
        assert_visible_review(review_titles, 0)
      end
  end
end