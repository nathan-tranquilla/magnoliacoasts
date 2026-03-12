type testimonial = {
  name: string,
  date: string,
  text: string,
  imageAlt: string,
}

let testimonials = [
  {
    name: "Erika McNabb",
    date: "November 2023",
    text: "Working with Stephanie was one of the best decisions we ever made! Her easy and friendly manner, professionalism and attention to detail made for a memorable and enjoyable experience. We absolutely love our family photos! Thank you, Stephanie, for capturing beautiful moments that will now become lasting memories.",
    imageAlt: "Family by road.",
  },
  {
    name: "Nritya Bhumi Studio",
    date: "August 2023",
    text: `Steph is Best baby photographer in town hands down... She was so accommodating and very gentle and thoughtful  handling my 10 days old baby. When we arrived at the studio she was waiting for us at the door and greeted us (very welcoming)...during the entire photoshoot she was patient and cool. Next day only we got our first 5 pictures so we could share it with our family....`,
    imageAlt: "Baby laughing.",
  },
  {
    name: "Tisha McNama",
    date: "May 2024",
    text: `Stephanie is an extraordinary photographer! She is SO SO good with babies and kids that the photo session seems like a breeze. She takes beautiful and amazing photos. We have been going back to her for 5 years now and we have loved every single sessions and photos. Highly recommended`,
    imageAlt: "Baby pointing.",
  },
]

let count = Array.length(testimonials)

let cardClass = "card flex flex-col shadow-card rounded-md bg-white h-auto sm:min-h-[450px] max-w-[750px] grid grid-cols-10 grid-rows-[auto_auto_auto_1fr] gap-x-2 sm:gap-4 font-cormorant-garamond text-sm sm:text-base md:text-lg overflow-hidden"

let itemBase = "carousel-item row-start-1 col-start-1 duration-600 transition-all"
let itemVisible = itemBase
let itemLeft = itemBase ++ " opacity-0 -translate-x-[50rem]"
let itemRight = itemBase ++ " opacity-0 translate-x-[50rem]"

let btnClass = "group shrink-0 h-[3rem] w-[3rem] rounded-full flex justify-center items-center cursor-pointer border-2 border-border-warm bg-white/80 text-muted transition-all hover:scale-105 hover:border-text/40 hover:text-text/60 hover:shadow-md focus:border-text/40 focus:text-text/60 focus:shadow-md active:scale-95"

let chevron = (~rotation) =>
  <svg
    className={`h-6 w-6 ${rotation}`}
    viewBox="0 0 32 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="1.4"
    strokeLinecap="round"
    strokeLinejoin="round">
    <line x1="2" y1="12" x2="28" y2="12" />
    <polyline points="22 6 28 12 22 18" />
  </svg>

let dotBase = "mx-2 h-[0.75rem] w-[0.75rem] rotate-45 rounded-[2px] border hover:scale-130 cursor-pointer transition-all"
let dotInactive = dotBase ++ " border-border-warm bg-light-pink"
let dotActive = dotBase ++ " scale-130 border-pink-border bg-pink"

@react.component
let make = (~images: array<string>) => {
  let (index, setIndex) = React.useState(() => 0)

  <div className="mx-4 flex max-w-dvw flex-col items-center justify-center md:mx-0">
    <div className="grid grid-cols-1 overflow-hidden">
      {testimonials
      ->Array.mapWithIndex((t, i) => {
        let itemClass = if i == index {
          itemVisible
        } else if i < index {
          itemLeft
        } else {
          itemRight
        }
        let imageSrc = images->Array.get(i)->Option.getOr("")
        <div key={Int.toString(i)} className={itemClass}>
          <div className={cardClass}>
            <div className="col-span-4 col-start-1 row-span-4 row-start-1 flex items-stretch justify-start">
              <img
                className="h-full w-full object-cover object-center"
                src={imageSrc}
                alt={t.imageAlt}
                loading=#lazy
              />
            </div>
            <div className="col-span-6 col-start-5 row-start-1 font-semibold whitespace-nowrap pr-3 sm:pr-6 pt-3 sm:pt-6 md:row-start-2">
              {React.string(t.name)}
            </div>
            <div className="col-span-6 col-start-5 row-start-2 font-light pr-3 sm:pr-6 md:row-start-3">
              {React.string(t.date)}
            </div>
            <div className="row-span-full col-span-6 col-start-5 row-start-3 text-sm sm:text-base pr-3 sm:pr-6 pb-3 sm:pb-6 md:row-start-4">
              {React.string(t.text)}
            </div>
          </div>
        </div>
      })
      ->React.array}
    </div>
    <div className="mt-2 sm:mt-4 flex items-center justify-center gap-4">
      <button
        id="carousel-go-left"
        className={btnClass}
        title="Previous Slide"
        onClick={_ => setIndex(prev => max(0, prev - 1))}>
        {chevron(~rotation="rotate-180")}
      </button>
      <div className="flex items-center">
        {Belt.Array.makeBy(count, i =>
          <div
            key={Int.toString(i)}
            className={if i == index { dotActive } else { dotInactive }}
            onClick={_ => setIndex(_ => i)}
            role="button"
            tabIndex={0}
            onKeyDown={e => {
              let key = e->ReactEvent.Keyboard.key
              if key == "Enter" || key == " " {
                ReactEvent.Keyboard.preventDefault(e)
                setIndex(_ => i)
              }
            }}
            ariaLabel={`Go to slide ${Int.toString(i + 1)}`}
          />
        )->React.array}
      </div>
      <button
        id="carousel-go-right"
        className={btnClass}
        title="Next Slide"
        onClick={_ => setIndex(prev => min(count - 1, prev + 1))}>
        {chevron(~rotation="")}
      </button>
    </div>
  </div>
}
