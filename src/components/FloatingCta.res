@react.component
let make = (~href: string, ~label: string) => {
  let (visible, setVisible) = React.useState(() => false)

  React.useEffect0(() => {
    let intro = Webapi.Dom.Document.querySelector(
      Webapi.Dom.document,
      "p.font-cormorant-garamond",
    )
    switch intro {
    | Some(el) => {
        let observer = Webapi.IntersectionObserver.make((entries, _observer) => {
          entries->Array.forEach(entry => {
            setVisible(_ => !Webapi.IntersectionObserver.IntersectionObserverEntry.isIntersecting(entry))
          })
        })
        Webapi.IntersectionObserver.observe(observer, el)
        Some(() => Webapi.IntersectionObserver.disconnect(observer))
      }
    | None => None
    }
  })

  <a
    href
    className={`bg-dark-green font-cormorant-garamond fixed bottom-6 right-6 z-40 rounded-full px-6 py-3 text-lg font-semibold text-white shadow-lg transition-all duration-300 hover:bg-green-900 md:bottom-8 md:right-8 ${visible
        ? "opacity-100"
        : "opacity-0 pointer-events-none"}`}
    ariaHidden={!visible}>
    {React.string(label ++ ` \u2192`)}
  </a>
}
