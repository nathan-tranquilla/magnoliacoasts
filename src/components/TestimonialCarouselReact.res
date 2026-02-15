// Testimonial carousel component with SSR support and client-side hydration
// Server-renders all testimonials, hydrates navigation functionality
@react.component
let make = (~children, ~count: int) => {
  let (currentIndex, setCurrentIndex) = React.useState(() => 0)

  let goLeft = () => {
    setCurrentIndex(i => max(0, i - 1))
  }

  let goRight = () => {
    setCurrentIndex(i => min(count - 1, i + 1))
  }

  let goTo = (index: int) => {
    setCurrentIndex(_ => index)
  }

  let dotClass = "m-4 h-[0.75rem] w-[0.75rem] rounded-full border border-[#ACABAC] hover:scale-130 cursor-pointer bg-app-grey transition-all"
  let slotContClass = "duration-600 transition-all"

  // Convert children to array if it isn't already
  let childrenArray = React.Children.toArray(children)

  <div>
    <div className="relative mx-4 flex max-w-dvw items-center justify-center overflow-hidden md:mx-0">
      {childrenArray
      ->Array.mapWithIndex((child, index) => {
        let isActive = index == currentIndex
        let moveClass = if isActive {
          ""
        } else if currentIndex > index {
          "move-left"
        } else {
          "move-right"
        }
        <div
          key={Belt.Int.toString(index)}
          id={`slot-container-${Belt.Int.toString(index)}`}
          className={`${slotContClass} ${moveClass}`}>
          {child}
        </div>
      })
      ->React.array}
    </div>
    <div className="mt-8 flex items-center justify-around">
      <button
        id="carousel-go-left"
        className="px-4 py-2 cursor-pointer"
        onClick={_ => goLeft()}
        title="Previous Slide"
        ariaLabel="Previous Slide">
        {React.string("<")}
      </button>
      <div className="flex items-center">
        {Array.fromInitializer(~length=count, i => {
          let isActive = i == currentIndex
          let activeClass = if isActive { "active-dot" } else { "" }
          <div
            key={Belt.Int.toString(i)}
            id={`carousel-go-${Belt.Int.toString(i)}`}
            className={`dots ${dotClass} ${activeClass}`}
            onClick={_ => goTo(i)}
            role="button"
            tabIndex={0}
            onKeyDown={e => {
              let key = e->ReactEvent.Keyboard.key
              if key == "Enter" || key == " " {
                ReactEvent.Keyboard.preventDefault(e)
                goTo(i)
              }
            }}
            ariaLabel={`Go to slide ${Belt.Int.toString(i + 1)}`}
          />
        })->React.array}
      </div>
      <button
        id="carousel-go-right"
        className="px-4 py-2 cursor-pointer"
        onClick={_ => goRight()}
        title="Next Slide"
        ariaLabel="Next Slide">
        {React.string(">")}
      </button>
    </div>
  </div>
}
