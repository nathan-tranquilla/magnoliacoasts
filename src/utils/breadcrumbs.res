let segmentNames = Dict.fromArray([
  ("gallery", "Gallery"),
  ("investment", "Investment"),
  ("about", "About"),
  ("maternity", "Maternity"),
  ("newborn", "Newborn"),
  ("family", "Family"),
  ("cakesmash", "Cake Smash"),
  ("milestones", "Milestones"),
  ("milestone", "Milestone"),
  ("children", "Children"),
  ("branding", "Branding"),
  ("headshots", "Headshots"),
  ("headshot", "Headshots"),
  ("collections", "Collections"),
])

let getSegmentName = (seg: string): string =>
  segmentNames
  ->Dict.get(seg)
  ->Option.getOr(seg->String.charAt(0)->String.toUpperCase ++ seg->String.slice(~start=1, ~end=seg->String.length))

type breadcrumbItem = {
  @as("@type") type_: string,
  position: int,
  name: string,
  item: string,
}

let buildBreadcrumbItems = (pathname: string, websiteUrl: string): array<breadcrumbItem> => {
  let pathSegments =
    pathname
    ->String.replaceRegExp(%re("/\/$/"), "")
    ->String.split("/")
    ->Array.filter(s => s !== "")

  let home = {type_: "ListItem", position: 1, name: "Home", item: websiteUrl ++ "/"}

  let items =
    pathSegments->Array.mapWithIndex((seg, i) => {
      let path = pathSegments->Array.slice(~start=0, ~end=i + 1)->Array.join("/")
      {
        type_: "ListItem",
        position: i + 2,
        name: getSegmentName(seg),
        item: websiteUrl ++ "/" ++ path,
      }
    })

  [home]->Array.concat(items)
}

let buildBreadcrumbSchema = (pathname: string, websiteUrl: string): Nullable.t<string> => {
  let pathSegments =
    pathname
    ->String.replaceRegExp(%re("/\/$/"), "")
    ->String.split("/")
    ->Array.filter(s => s !== "")

  if pathSegments->Array.length > 0 {
    let items = buildBreadcrumbItems(pathname, websiteUrl)
    Nullable.make(
      JSON.stringifyAny({
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
        "itemListElement": items,
      })->Option.getOr(""),
    )
  } else {
    Nullable.null
  }
}

type pathInfo = {
  segments: array<string>,
  names: array<string>,
  hrefs: array<string>,
}

let getPathInfo = (pathname: string, baseUrl: string): pathInfo => {
  let segments =
    pathname
    ->String.replaceRegExp(%re("/\/$/"), "")
    ->String.split("/")
    ->Array.filter(s => s !== "")

  let names = segments->Array.map(getSegmentName)
  let hrefs = segments->Array.mapWithIndex((_, i) => {
    let path = segments->Array.slice(~start=0, ~end=i + 1)->Array.join("/")
    baseUrl ++ "/" ++ path
  })

  {segments, names, hrefs}
}
