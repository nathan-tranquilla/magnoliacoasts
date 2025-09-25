open Webapi.Dom
open DomTokenList

// Initialize the app when DOM is ready
let onReady = (callback: unit => unit): unit => {
  let handleDOMContentLoaded = _ => callback()
  window->Window.addEventListener("DOMContentLoaded", handleDOMContentLoaded)
}

// Query the DOM for existing elements
module Query = {
  type t = Dom.element
  let getById = (id: string): option<t> => document->Document.getElementById(id)
  let getBySelector = (selector: string): array<t> =>
    document
    ->Document.querySelectorAll(selector)
    ->NodeList.toArray
    ->Belt.Array.keepMap(Element.ofNode)
}

// // Element creation and manipulation
module Element = {
  type t = Dom.element
  let addClass = (el: t, className: string): unit => {
    el->Element.classList->add(className)
  }
  let removeClass = (el: t, className: string): unit => {
    el->Element.classList->remove(className)
  }
  let onClick = (el: t, callback: unit => unit): unit => {
    el->Element.addEventListener("click", _ => callback())
  }
  let getChildren = (el: t): array<t> => {
    el->Element.children->Webapi.Dom.HtmlCollection.toArray
  }
  
}

module Dataset = {
  type t = Dom.domStringMap
  type el = Dom.element

  let getDataset = (el: el): option<t> => {
    el->Webapi.Dom.Element.asHtmlElement->Belt.Option.map(_, HtmlElement.dataset)
  }
}

// Optional reactivity with signals
module Signal = {
  type t<'a> = {value: ref<'a>, subscribers: ref<array<'a => unit>>}

  let create = (initial: 'a): t<'a> => {value: ref(initial), subscribers: ref([])}
  let get = (signal: t<'a>): 'a => signal.value.contents
  let set = (signal: t<'a>, value: 'a): unit => {
    signal.value.contents = value
    signal.subscribers.contents->Belt.Array.forEach(cb => cb(value))
  }
  let subscribe = (signal: t<'a>, fn: 'a => 'b): unit => {
    signal.subscribers.contents->Array.push(fn)
  }
}

