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
