let init = () => {
  let i = ReQuery.Signal.create(0)
  ReQuery.Signal.subscribe(i, v => {
    Console.log("Current carousel selection is index: " ++ Belt.Int.toString(v))
  })
  ReQuery.onReady(() => {
    let limit = ReQuery.Query.getBySelector(".carousel .dots")->Belt.Array.length - 1
    Console.log("Number of carousel items: " ++ Belt.Int.toString(limit))
    switch ReQuery.Query.getById("carousel-go-left") {
    | None => ()
    | Some(el) =>
      ReQuery.Element.onClick(el, () => {
        let ci = max(0, ReQuery.Signal.get(i) - 1)
        ReQuery.Signal.set(i, ci)
      })
    }
    switch ReQuery.Query.getById("carousel-go-right") {
    | None => ()
    | Some(el) =>
      ReQuery.Element.onClick(el, () => {
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
          ReQuery.Signal.subscribe(i, v => {
            if v == x {
              ReQuery.Element.addClass(el, "active-dot")
            } else {
              ReQuery.Element.removeClass(el, "active-dot")
            }
          })
        }
      }
    }
    for x in 0 to limit {
      switch ReQuery.Query.getById("slot-container-" ++ Belt.Int.toString(x)) {
      | None => ()
      | Some(el) => ReQuery.Signal.subscribe(i, v => {
          if v == x {
            ReQuery.Element.removeClass(el, "move-left")
            ReQuery.Element.removeClass(el, "move-right")
          } else if v > x {
            ReQuery.Element.addClass(el, "move-left")
          } else if v < x {
            ReQuery.Element.addClass(el, "move-right")
          }
        })
      }
    }
  })
}
