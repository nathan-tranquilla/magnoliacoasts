open Webapi.Dom.DomStringMap


let init = (message_selector, dismiss_id) => {
  ReQuery.onReady(() => {
    let dismissSignal = ReQuery.Signal.create(false)
    
    let messages = ReQuery.Query.getBySelector(message_selector)
    Console.log("Found messages: " ++ Belt.Int.toString(messages->Array.length))
    messages->Array.forEach(el => {
      ReQuery.Signal.subscribe(dismissSignal, v => {
        if v == true {
          el->ReQuery.Element.removeClass("message--show")
          el->ReQuery.Element.addClass("message--hide")
        } else {
          el->ReQuery.Element.removeClass("message--hide")
          el->ReQuery.Element.addClass("message--show")
        }
      })
      let maybeStartDate = ReQuery.Dataset.getDataset(el)
        ->Option.flatMap(ds => ds->get("startdate"))
      let maybeEndDate = ReQuery.Dataset.getDataset(el)
        ->Option.flatMap(ds => ds->get("enddate"))
      switch (maybeStartDate, maybeEndDate) {
      | (Some(startDate), Some(endDate)) => {
          Console.log("found attributes")
          let currentDate = Date.make()
          let currentYear = currentDate->Date.getFullYear
          let startParts = startDate->String.split("-")->Array.map(str => Belt.Int.fromString(str))
          let endParts = endDate->String.split("-")->Array.map(str => Belt.Int.fromString(str))
          switch (startParts[0], startParts[1], endParts[0], endParts[1]) {
          | (Some(Some(sm)), Some(Some(sd)), Some(Some(em)), Some(Some(ed))) => {
              let startDate = Date.makeWithYMD(~year=currentYear, ~month=sm, ~date=sd)
              let endDate = Date.makeWithYMD(~year=currentYear, ~month=em, ~date=ed)
              if currentDate->Date.compare(startDate) >= 0. && currentDate->Date.compare(endDate) <= 0. {
                Console.log("Activating banner message...")
                el->ReQuery.Element.removeClass("message--hide")
                el->ReQuery.Element.addClass("message--show")
              } else {
                Console.log("Current date " ++ currentDate->Date.toDateString ++ " is not within date range " ++ startDate->Date.toDateString ++ " - " ++ endDate->Date.toDateString)
                el->ReQuery.Element.removeClass("message--show")
                el->ReQuery.Element.addClass("message--hide")
              }
            }
          | _ => ()
          }
        }
      | _ => ()
      }
    })

    let dismissButton = ReQuery.Query.getById(dismiss_id)
    dismissButton->Option.forEach(el => {
      Console.log(el)
      el->ReQuery.Element.onClick(() => {
        Dom.Storage.setItem("banner_dismissed", "true", Dom.Storage.localStorage)
        ReQuery.Signal.set(dismissSignal, true)
      })
    })

    let dismissedOption = Dom.Storage.getItem("banner_dismissed", Dom.Storage.localStorage)
    dismissedOption->Option.forEach(dis => {
      if dis == "true" {
        ReQuery.Signal.set(dismissSignal, true)
      }
    })
  })
}