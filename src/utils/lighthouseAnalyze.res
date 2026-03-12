%%raw(`
import * as _fs from 'fs'
import * as _path from 'path'
`)

let readFileSync: string => string = %raw(`(p) => _fs.readFileSync(p, 'utf8')`)
let readdirSync: string => array<string> = %raw(`(p) => _fs.readdirSync(p)`)
let joinPath: (string, string) => string = %raw(`(a, b) => _path.join(a, b)`)
let parseJson: string => JSON.t = %raw(`(s) => JSON.parse(s)`)

let getFloat = (json: JSON.t, key: string): float => {
  switch json->JSON.Decode.object {
  | Some(obj) =>
    switch obj->Dict.get(key) {
    | Some(v) =>
      switch v->JSON.Decode.float {
      | Some(f) => f
      | None => 0.0
      }
    | None => 0.0
    }
  | None => 0.0
  }
}

let getString = (json: JSON.t, key: string): string => {
  switch json->JSON.Decode.object {
  | Some(obj) =>
    switch obj->Dict.get(key) {
    | Some(v) =>
      switch v->JSON.Decode.string {
      | Some(s) => s
      | None => ""
      }
    | None => ""
    }
  | None => ""
  }
}

let getObj = (json: JSON.t, key: string): JSON.t => {
  switch json->JSON.Decode.object {
  | Some(obj) =>
    switch obj->Dict.get(key) {
    | Some(v) => v
    | None => JSON.Encode.null
    }
  | None => JSON.Encode.null
  }
}

let getArray = (json: JSON.t, key: string): array<JSON.t> => {
  switch json->JSON.Decode.object {
  | Some(obj) =>
    switch obj->Dict.get(key) {
    | Some(v) =>
      switch v->JSON.Decode.array {
      | Some(a) => a
      | None => []
      }
    | None => []
    }
  | None => []
  }
}

let lhDir = ".lighthouseci"

let latestReport = () => {
  let files =
    readdirSync(lhDir)
    ->Array.filter(f => f->String.startsWith("lhr-") && f->String.endsWith(".json"))
    ->Array.toSorted(String.compare)

  switch files->Array.at(-1) {
  | Some(f) => joinPath(lhDir, f)
  | None => panic("No lighthouse reports found in .lighthouseci/")
  }
}

let analyze = () => {
  let path = latestReport()
  let r = readFileSync(path)->parseJson

  let categories = r->getObj("categories")
  let audits = r->getObj("audits")

  Console.log("=== SCORES ===")
  let catNames = ["performance", "accessibility", "best-practices", "seo"]
  catNames->Array.forEach(name => {
    let cat = categories->getObj(name)
    let score = cat->getFloat("score")
    Console.log(`${name}: ${score->Float.toString}`)
  })

  Console.log("\n=== FAILING PERFORMANCE AUDITS ===")
  let perfCat = categories->getObj("performance")
  let auditRefs = perfCat->getArray("auditRefs")
  auditRefs->Array.forEach(ref => {
    let id = ref->getString("id")
    let audit = audits->getObj(id)
    let score = audit->getFloat("score")
    if score < 0.9 {
      let displayValue = audit->getString("displayValue")
      let title = audit->getString("title")
      Console.log(`${id}: score=${score->Float.toString} | ${displayValue} | ${title}`)
    }
  })

  Console.log("\n=== KEY METRICS ===")
  let metrics = [
    "first-contentful-paint",
    "largest-contentful-paint",
    "total-blocking-time",
    "cumulative-layout-shift",
    "speed-index",
    "interactive",
  ]
  metrics->Array.forEach(id => {
    let audit = audits->getObj(id)
    let displayValue = audit->getString("displayValue")
    Console.log(`${id}: ${displayValue}`)
  })

  Console.log("\n=== LCP BREAKDOWN ===")
  let lcpAudit = audits->getObj("largest-contentful-paint-element")
  let lcpDetails = lcpAudit->getObj("details")
  let lcpItems = lcpDetails->getArray("items")
  lcpItems->Array.forEach(item => {
    let subItems = item->getArray("items")
    subItems->Array.forEach(j => {
      let phase = j->getString("phase")
      let snippet = j->getObj("node")->getString("snippet")
      if phase != "" {
        let timing = j->getFloat("timing")
        let percent = j->getString("percent")
        Console.log(`${phase}: ${timing->Float.toString}ms (${percent})`)
      }
      if snippet != "" {
        Console.log(`Element: ${snippet}`)
      }
    })
  })

  Console.log("\n=== IMAGE DELIVERY ===")
  let imgAudit = audits->getObj("image-delivery-insight")
  let imgDetails = imgAudit->getObj("details")
  let imgItems = imgDetails->getArray("items")
  imgItems->Array.forEach(i => {
    let url = i->getString("url")
    let wasted = i->getFloat("wastedBytes")
    Console.log(`${url} | wasted=${wasted->Float.toString}B`)
  })
}

analyze()
