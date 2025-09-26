require "spec_helper"
require "support/constants"

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "(#{driver}) carousel", type: :feature, driver: driver, testimonials: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }
      def assert_visible_review(review_titles, visible_index)
        review_titles.each_with_index do |title, i|
          if i == visible_index
            expect(page).to have_selector(".card", text: title, visible: true)
          else
            expect(page).to have_no_selector(".card", text: title, visible: true)
          end
        end
      end

      it "works" do
        visit "/"
        within(".testimonials") do 
          left_button = find('button#carousel-go-left', visible: :all)
          right_button = find('button#carousel-go-right', visible: :all)
          review_titles = ["Erika McNabb", "Nritya Bhumi Studio", "Tisha McNama"]

          # Initial: Erika McNabb
          assert_visible_review(review_titles, 0)

          # Click right: Nritya
          right_button.click
          assert_visible_review(review_titles, 1)

          # Click right: Tisha
          right_button.click
          assert_visible_review(review_titles, 2)

          # Click right: Still Tisha (end of carousel)
          right_button.click
          assert_visible_review(review_titles, 2)

          # Go backwards
          left_button.click
          assert_visible_review(review_titles, 1)

          left_button.click
          assert_visible_review(review_titles, 0)

          # Clicking left again should still show Erika (start of carousel)
          left_button.click
          assert_visible_review(review_titles, 0)
        end 
      end 
  end
end