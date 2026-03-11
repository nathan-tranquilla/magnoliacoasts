let get_surrounding_pkgs = (pkg: (string, string), packages: array<(string, string)>): ((string,string), (string,string)) =>
  packages
  ->Array.indexOfOpt(pkg)
  ->Belt.Option.flatMap(i =>
    switch (packages->Array.at(i - 1), packages->Array.at(Int.mod(i + 1, packages->Array.length))) {
    | (Some(prev), Some(next)) => Some((prev, next))
    | _ => None
    }
  )
  ->Belt.Option.getWithDefault((("",""), ("","")))

// Package booking links
let packageLinks = Dict.fromArray([
  ("maternityPackages", "https://book.usesession.com/t/m-PqP2slk"),
  ("newbornPackages", "https://book.usesession.com/t/jzCdVHVNT"),
  ("milestonePackages", "https://book.usesession.com/t/aOqs7teEf"),
  ("familyPackages", "https://book.usesession.com/t/qSKGXDFg9"),
  ("headshotPackages", "https://book.usesession.com/t/MuL13nQbW"),
  ("collectionsPackages", "https://book.usesession.com/i/_ji73Jr_e/inquire"),
])

let getPackageLink = (pkgType: string): string =>
  packageLinks->Dict.get(pkgType)->Option.getOr("")

// Package display tuples: (label, url)
let packageTuples = [
  ("maternityPackages", ("Maternity Packages", "/investment/maternity")),
  ("newbornPackages", ("Newborn Packages", "/investment/newborn")),
  ("milestonePackages", ("Milestone Packages", "/investment/milestone")),
  ("familyPackages", ("Family Packages", "/investment/family")),
  ("headshotPackages", ("Headshot, Branding & Portrait Packages", "/investment/headshot")),
  ("collectionsPackages", ("Collections Packages", "/investment/collections")),
]

let allPackageTuples = packageTuples->Array.map(((_, tuple)) => tuple)

let getPackageTuple = (pkgType: string): (string, string) =>
  packageTuples
  ->Array.find(((key, _)) => key === pkgType)
  ->Option.map(((_, tuple)) => tuple)
  ->Option.getOr(("", ""))

// Extract prices from collection data for Service schema
type packageData = {
  price: option<float>,
  priceRange: option<string>,
}

let extractPrices = (packages: array<packageData>): array<string> =>
  packages
  ->Array.filterMap(p =>
    switch p.price {
    | Some(price) => Some(Float.toString(price))
    | None =>
      switch p.priceRange {
      | Some(range) if range->String.length > 0 => Some(range)
      | _ => None
      }
    }
  )
