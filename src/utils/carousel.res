let init = () => {
  let i = ReQuery.Signal.create(0)
  ReQuery.Signal.subscribe(i, (v) => {
    Console.log("Value changed to "++Belt.Int.toString(v))
  })
  ReQuery.onReady(() => {
    let limit = ReQuery.Query.getBySelector(".carousel .dots")->Belt.Array.length-1
    Console.log("limit is :" ++ Belt.Int.toString(limit))
    switch ReQuery.Query.getById("carousel-go-left") {
    | None => ()
    | Some(el) => ReQuery.Element.onClick(el, () => {
      let ci = max(0, ReQuery.Signal.get(i) - 1)
      ReQuery.Signal.set(i, ci)
    })
    }
    switch ReQuery.Query.getById("carousel-go-right") {
    | None => ()
    | Some(el) => ReQuery.Element.onClick(el, () => {
      let ci = min(limit, ReQuery.Signal.get(i) + 1)
      ReQuery.Signal.set(i, ci)
    })
    }
    for x in 0 to limit {
      switch ReQuery.Query.getById("carousel-go-" ++ Belt.Int.toString(x)) {
      | None => ()
      | Some(el) => {
          ReQuery.Element.onClick(el, () => {
            ReQuery.Signal.set(i, x)
          })
          ReQuery.Signal.subscribe(i, (v) => {
            if v == x {
              ReQuery.Element.removeClass(el, "bg-app-grey")
              ReQuery.Element.addClass(el, "bg-app-dark-grey")
            } else {
              ReQuery.Element.removeClass(el, "bg-app-dark-grey")
              ReQuery.Element.addClass(el, "bg-app-grey")
            }
          })
        }
      }
    }
    for x in 0 to limit {
      switch ReQuery.Query.getById("slot-container-" ++ Belt.Int.toString(x)) {
      | None => ()
      | Some(el) => {
          Console.log("here "++ Belt.Int.toString(x))
          ReQuery.Signal.subscribe(i, (v) => {
            if v == x {
              ReQuery.Element.removeClass(el, "absolute")
              ReQuery.Element.removeClass(el, "translate-x-400")
              ReQuery.Element.removeClass(el, "-translate-x-400")
            } else if v > x {
              ReQuery.Element.addClass(el, "absolute")
              ReQuery.Element.removeClass(el, "translate-x-400")
              ReQuery.Element.addClass(el, "-translate-x-400")
            } else if v < x {
              ReQuery.Element.addClass(el, "absolute")
              ReQuery.Element.removeClass(el, "-translate-x-400")
              ReQuery.Element.addClass(el, "translate-x-400")
            }
          })
        }
      }
    }
  })  
}