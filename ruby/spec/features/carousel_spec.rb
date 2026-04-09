require "spec_helper"

# Tests the Carousel React component (Carousel.res) rendered via TestimonialCarousel.astro
# on the homepage. The carousel has 3 testimonial slides, prev/next buttons, and dot indicators.
#
# DOM structure:
#   - Slides: .carousel-item divs; visible slide lacks opacity-0, hidden slides have opacity-0
#   - Buttons: <button title="Previous Slide"> and <button title="Next Slide">
#   - Dots: active dot has "!bg-app-active-grey" in class

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "Testimonial carousel (#{driver})", type: :feature, driver: driver, tag: :carousel do
    before do
      Capybara.current_driver = driver
      visit "/"
    end
    after { Capybara.use_default_driver }

    let(:testimonial_section) { find(".testimonials") }

    def all_slides
      within(testimonial_section) do
        all(".carousel-item", visible: :all)
      end
    end

    def visible_slide
      all_slides.find { |el| !el[:class].include?("opacity-0") }
    end

    def hidden_slides
      all_slides.select { |el| el[:class].include?("opacity-0") }
    end

    def next_button
      within(testimonial_section) { find("button[title='Next Slide']") }
    end

    def prev_button
      within(testimonial_section) { find("button[title='Previous Slide']") }
    end

    def active_dot_count
      within(testimonial_section) do
        all("[class*='!bg-app-active-grey']", visible: :all).count
      end
    end

    def dots
      within(testimonial_section) do
        all("[class*='bg-app-grey'], [class*='!bg-app-active-grey']", visible: :all)
      end
    end

    it "renders all 3 slides on initial load" do
      expect(all_slides.count).to eq(3)
    end

    it "shows only the first slide initially" do
      expect(visible_slide).not_to be_nil
      expect(hidden_slides.count).to eq(2)
    end

    it "has exactly one active dot initially" do
      expect(active_dot_count).to eq(1)
    end

    it "advances to the next slide when clicking Next" do
      first_visible_text = visible_slide.text(:all)
      next_button.trigger("click")
      sleep 0.3
      expect(visible_slide.text(:all)).not_to eq(first_visible_text)
      expect(hidden_slides.count).to eq(2)
    end

    it "does not go before the first slide when clicking Previous at start" do
      first_visible_text = visible_slide.text(:all)
      prev_button.trigger("click")
      sleep 0.3
      expect(visible_slide.text(:all)).to eq(first_visible_text)
    end

    it "navigates forward through all slides and back" do
      texts = [visible_slide.text(:all)]

      # Forward to slide 2
      next_button.trigger("click")
      sleep 0.3
      texts << visible_slide.text(:all)

      # Forward to slide 3
      next_button.trigger("click")
      sleep 0.3
      texts << visible_slide.text(:all)

      # All 3 slides should have different content
      expect(texts.uniq.count).to eq(3)

      # Should not advance past last slide
      next_button.trigger("click")
      sleep 0.3
      expect(visible_slide.text(:all)).to eq(texts.last)

      # Back to slide 2
      prev_button.trigger("click")
      sleep 0.3
      expect(visible_slide.text(:all)).to eq(texts[1])

      # Back to slide 1
      prev_button.trigger("click")
      sleep 0.3
      expect(visible_slide.text(:all)).to eq(texts[0])
    end

    it "jumps to a slide when clicking a dot" do
      first_text = visible_slide.text(:all)

      # Click the third dot (index 2)
      d = dots
      d[2].trigger("click") if d.count >= 3
      sleep 0.3

      expect(visible_slide.text(:all)).not_to eq(first_text)
      expect(hidden_slides.count).to eq(2)
    end

    it "maintains exactly one active dot after navigation" do
      next_button.trigger("click")
      sleep 0.3
      expect(active_dot_count).to eq(1)

      next_button.trigger("click")
      sleep 0.3
      expect(active_dot_count).to eq(1)
    end
  end
end
