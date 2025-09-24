open Webapi.Dom
open DomTokenList

// Initialize the app when DOM is ready
let onReady = (callback: unit => unit): unit => {
  let handler = ref(None)
  let handleDOMContentLoaded = _ => {
    callback()
    switch handler.contents {
    | Some(h) => window->Window.removeEventListener("DOMContentLoaded", h)
    | None => ()
    }
  }
  let eventHandler = handleDOMContentLoaded
  handler := Some(eventHandler)
  window->Window.addEventListener("DOMContentLoaded", eventHandler)
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

//   let getBySelector = (selector: string): array<n> =>
//     document->Document.querySelectorAll(selector)->NodeList.toArray
//   let firstBySelector = (selector: string): option<t> =>
//     document->Document.querySelector(selector)

//   // Attach dynamism to existing elements
//   let addClick = (el: option<t>, callback: unit => unit): unit => {
//     Belt.Option.forEach(el, e => e->Element.addEventListener("click", _ => callback()))
//   }
//   let addEvent = (el: option<t>, event: string, callback: unit => unit): unit => {
//     Belt.Option.forEach(el, e => e->Element.addEventListener(event, _ => callback()))
//   }
//   let setText = (el: option<t>, text: string): unit => {
//     Belt.Option.forEach(el, e => e->Element.setInnerText(text))
//   }
//   let addClass = (el: option<t>, className: string): unit => {
//     Belt.Option.forEach(el, e => e->Element.classList->add(className))
//   }
//   let removeClass = (el: option<t>, className: string): unit => {
//     Belt.Option.forEach(el, e => e->Element.classList->remove(className))
//   }
//   let toggleClass = (el: option<t>, className: string): unit => {
//     Belt.Option.forEach(el, e => { ignore(e->Element.classList->toggle(className)) })
//   }
// }

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
  
}

module Dataset = {
  type t = Dom.domStringMap
  type el = Dom.element

  let getDataset = (el: el): option<t> => {
    el->Webapi.Dom.Element.asHtmlElement->Belt.Option.map(_, HtmlElement.dataset)
  }
}
//   // Generic element creation
//   let create = (~tag: string, ~attrs: list<(string, string)>, ~children: list<t>): t => {
//     let el = document->Document.createElement(tag)
//     attrs->Belt.List.forEach(((key, value)) => el->Element.setAttribute(key, value))
//     children->Belt.List.forEach(child => el->Element.appendChild(~child=child))
//     el
//   }

//   // Common HTML elements (PureScript-inspired)
//   let a = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="a", ~attrs, ~children)
//   let p = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="p", ~attrs, ~children)
//   let h1 = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="h1", ~attrs, ~children)
//   let h2 = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="h2", ~attrs, ~children)
//   let div = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="div", ~attrs, ~children)
//   let span = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="span", ~attrs, ~children)
//   let input = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="input", ~attrs, ~children)
//   let button = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="button", ~attrs, ~children)
//   let ul = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="ul", ~attrs, ~children)
//   let li = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="li", ~attrs, ~children)
//   let form = (~attrs: list<(string, string)>, ~children: list<t>): t =>
//     create(~tag="form", ~attrs, ~children)
//   let br = (~attrs: list<(string, string)>): t => create(~tag="br", ~attrs, ~children=list{})

//   // Text node creation
//   let text = (content: string): t =>
//     document
//     ->Document.createTextNode(content)
//     ->Text.asNode

//   // Manipulation
//   let setText = (el: t, text: string): unit => el->Element.setInnerText(text)
//   let appendTo = (child: t, parent: t): unit => parent->Element.appendChild(child)
//   let onClick = (el: t, callback: unit => unit): unit => {
//     el->Element.addEventListener("click", _ => callback())
//   }
//   let onEvent = (el: t, event: string, callback: unit => unit): unit => {
//     el->Element.addEventListener(event, _ => callback())
//   }
//   let addClass = (el: t, className: string): unit => {
//     el->Element.classList->ClassList.add(className)
//   }
//   let removeClass = (el: t, className: string): unit => {
//     el->Element.classList->ClassList.remove(className)
//   }
//   let toggleClass = (el: t, className: string): unit => {
//     el->Element.classList->ClassList.toggle(className)
//   }
// }

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
//   let map = (signal: t<'a>, fn: 'a => 'b): t<'b> => {
//     let mapped = create(fn(signal.value))
//     signal.subscribers.contents = [
//       v => set(mapped, fn(v)),
//       ...signal.subscribers.contents,
//     ]
//     mapped
//   }
//   let bindText = (el: Element.t, signal: t<string>): unit => {
//     Element.setText(el, signal.value)
//     signal.subscribers.contents = [
//       v => Element.setText(el, v),
//       ...signal.subscribers.contents,
//     ]
//   }
//   let bindClass = (el: Element.t, signal: t<string>): unit => {
//     Element.addClass(el, signal.value)
//     signal.subscribers.contents = [
//       v => {
//         Element.removeClass(el, signal.value)
//         Element.addClass(el, v)
//       },
//       ...signal.subscribers.contents,
//     ]
//   }
//   let bindAttr = (el: Element.t, attr: string, signal: t<string>): unit => {
//     el->Element.setAttribute(attr, signal.value)
//     signal.subscribers.contents = [
//       v => el->Element.setAttribute(attr, v),
//       ...signal.subscribers.contents,
//     ]
//   }
// }
// }
