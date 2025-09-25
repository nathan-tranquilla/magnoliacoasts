open Webapi.Dom

let showBanner = el => {
  el->ReQuery.Element.removeClass("message--hide")
  el->ReQuery.Element.addClass("message--show")
}

let hideBanner = el => {
  el->ReQuery.Element.removeClass("message--show")
  el->ReQuery.Element.addClass("transition-all")
  el->ReQuery.Element.addClass("message--hide")
}

let parseDate = (dateStr, year) => {
  let parts = dateStr->String.split("-")->Array.map(str => Belt.Int.fromString(str))
  switch (parts[0], parts[1]) {
  | (Some(Some(month)), Some(Some(day))) => Some(Date.makeWithYMD(~year=year, ~month=month, ~date=day))
  | _ => None
  }
}

let isCurrentInRange = (current, start, end_) =>
  current->Date.compare(start) >= 0. && current->Date.compare(end_) <= 0.

let addInteractivity = (message_selector, dismiss_id) => {
  let dismissSignal = ReQuery.Signal.create(false)
  let messages = ReQuery.Query.getBySelector(message_selector)
  Console.log("Found messages: " ++ Belt.Int.toString(messages->Array.length))

  let handleSignal = v =>
    messages->Array.forEach(el => if v { hideBanner(el) } else { showBanner(el) })
  ReQuery.Signal.subscribe(dismissSignal, handleSignal)

  let currentDate = Date.make()
  let currentYear = currentDate->Date.getFullYear

  messages->Array.forEach(el => {
    open Webapi.Dom.DomStringMap

    let maybeStartDate = ReQuery.Dataset.getDataset(el)
      ->Option.flatMap(ds => ds->get("startdate"))
    let maybeEndDate = ReQuery.Dataset.getDataset(el)
      ->Option.flatMap(ds => ds->get("enddate"))
    let templateId = ReQuery.Dataset.getDataset(el)
      ->Option.flatMap(ds => ds->get("templateid"))
    switch (maybeStartDate, maybeEndDate, templateId) {
    | (Some(startStr), Some(endStr), Some(templateId)) => {
        switch (parseDate(startStr, currentYear), parseDate(endStr, currentYear)) {
        | (Some(startDate), Some(endDate)) => {
            if isCurrentInRange(currentDate, startDate, endDate) {
              Console.log("Activating banner message...")
              let template = ReQuery.Query.getById(templateId)
              template->Option.forEach(temp => {
                el->Element.setInnerHTML(temp->Element.innerHTML)
              })
              showBanner(el)
            } else {
              Console.log("Current date " ++ currentDate->Date.toDateString ++ " is not within date range " ++ startDate->Date.toDateString ++ " - " ++ endDate->Date.toDateString)
              hideBanner(el)
            }
          }
        | _ => hideBanner(el)
        }
      }
    | _ => hideBanner(el)
    }
  })

  let dismissButton = ReQuery.Query.getById(dismiss_id)
  dismissButton->Option.forEach(el => {
    el->ReQuery.Element.onClick(() => {
      Dom.Storage.setItem("banner_dismissed", "true", Dom.Storage.localStorage)
      ReQuery.Signal.set(dismissSignal, true)
    })
  })

  Dom.Storage.getItem("banner_dismissed", Dom.Storage.localStorage)
  ->Option.forEach(dis => {
    if dis == "true" {
      ReQuery.Signal.set(dismissSignal, true)
    }
  })
}

let init = (message_selector, dismiss_id) => {
  ReQuery.onReady(() => {
    ignore(Js.Global.setTimeout(() => {
      addInteractivity(message_selector, dismiss_id)
    }, 1000))
  })
}