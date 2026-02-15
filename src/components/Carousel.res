open Webapi.Dom

@send external querySelectorAll: (Dom.element, string) => Dom.nodeList = "querySelectorAll"
@set external setClassName: (Dom.element, string) => unit = "className"

let buttonClass = "bg-white shrink-0 h-[3rem] w-[3rem] border-2 border-[#C5C5C5] rounded-full flex justify-center items-center text-[#C5C5C5] cursor-pointer hover:scale-110 hover:shadow-lg hover:text-app-active-grey hover:border-app-active-grey focus:shadow-lg focus:text-app-active-grey focus:border-app-active-grey transition-all"

let dotBase = "m-4 h-[0.75rem] w-[0.75rem] rounded-full border border-[#ACABAC] hover:scale-130 cursor-pointer transition-all"
let dotInactive = dotBase ++ " bg-app-grey"
let dotActive = dotBase ++ " scale-130 !bg-app-active-grey"

let itemBase = "carousel-item row-start-1 col-start-1 duration-600 transition-all"
let itemVisible = itemBase
let itemLeft = itemBase ++ " opacity-0 -translate-x-[50rem]"
let itemRight = itemBase ++ " opacity-0 translate-x-[50rem]"

@react.component
let make = (~count: int, ~children: React.element) => {
  let (index, setIndex) = React.useState(() => 0)
  let containerRef = React.useRef(Nullable.null)

  React.useEffect1(() => {
    containerRef.current
    ->Nullable.toOption
    ->Option.forEach(container => {
      container
      ->querySelectorAll(".carousel-item")
      ->NodeList.toArray
      ->Array.filterMap(Element.ofNode)
      ->Array.forEachWithIndex((el, i) => {
        if i == index {
          setClassName(el, itemVisible)
        } else if i < index {
          setClassName(el, itemLeft)
        } else {
          setClassName(el, itemRight)
        }
      })
    })
    None
  }, [index])

  <div className="mx-4 flex max-w-dvw flex-col items-center justify-center md:mx-0">
    <div
      ref={ReactDOM.Ref.domRef(containerRef)}
      className="grid grid-cols-1 overflow-hidden"
    >
      {children}
    </div>
    <div className="mt-8 flex w-full items-center justify-around">
      <button
        className={buttonClass}
        title="Previous Slide"
        onClick={_ => setIndex(prev => max(0, prev - 1))}
      >
        {React.string("<")}
      </button>
      <div className="flex items-center">
        {Belt.Array.makeBy(count, i =>
          <div
            key={Int.toString(i)}
            className={if i == index { dotActive } else { dotInactive }}
            onClick={_ => setIndex(_ => i)}
          />
        )->React.array}
      </div>
      <button
        className={buttonClass}
        title="Next Slide"
        onClick={_ => setIndex(prev => min(count - 1, prev + 1))}
      >
        {React.string(">")}
      </button>
    </div>
  </div>
}
