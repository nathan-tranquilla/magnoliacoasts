let string_to_id = (input: string): string => {
  open String
  input
    ->toLowerCase
    ->replaceAllRegExp(%re("/[^a-zA-Z0-9]+/g"), "-")
    ->replaceAllRegExp(%re("/^-+/g"), "")
    ->replaceAllRegExp(%re("/-+$/g"), "")

}

let is_active_link = (currentPath: string, href: string, baseUrl: string): bool => {
  if href == baseUrl ++ "/" {
    currentPath == "/" || currentPath == ""
  } else {
    currentPath->String.startsWith(href)
  }
}