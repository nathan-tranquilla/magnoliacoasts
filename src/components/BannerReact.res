// Banner component with SSR support and client-side hydration
// Server-renders content based on date range, hydrates dismiss functionality
@react.component
let make = (~content: React.element, ~shouldShow: bool) => {
  let (dismissed, setDismissed) = React.useState(() => false)

  // Load dismissed state from localStorage on mount
  React.useEffect(() => {
    open Webapi.Dom
    switch Dom.Storage.getItem("banner_dismissed", Dom.Storage.localStorage) {
    | Some(value) if value == "true" => setDismissed(_ => true)
    | _ => ()
    }
    None
  }, [])

  let handleDismiss = () => {
    open Webapi.Dom
    Dom.Storage.setItem("banner_dismissed", "true", Dom.Storage.localStorage)
    setDismissed(_ => true)
  }

  let isVisible = shouldShow && !dismissed
  
  let style = ReactDOMStyle.unsafeAddStyle(
    ReactDOMStyle.unsafeAddProp(
      ReactDOMStyle._dictToStyle(Js.Dict.empty()),
      "maxHeight",
      if isVisible { "175px" } else { "0px" }
    ),
    {"overflow": "hidden"}
  )

  <div
    className="relative flex justify-center items-center w-full h-fit text-sm font-mono text-white bg-blue-400 transition-all ease-in"
    style>
    <div className="flex justify-center items-center w-full">
      {content}
    </div>
    <button
      id="banner_dismiss"
      className="absolute top-0 right-0 translate-y-2 -translate-x-2 w-[1rem] h-[1rem] rounded-full flex justify-center items-center hover:opacity-100 focus:opacity-100 opacity-50 max-h-[24px] max-w-[24px]"
      onClick={_ => handleDismiss()}
      title="dismiss announcement"
      ariaLabel="dismiss announcement">
      {React.string("x")}
    </button>
  </div>
}
