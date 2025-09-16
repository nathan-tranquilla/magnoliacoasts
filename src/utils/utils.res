let string_to_id = (input: string): string => {
  open String
  input
    ->toLowerCase
    ->replaceAllRegExp(%re("/[^a-zA-Z0-9]+/g"), "-")
    ->replaceAllRegExp(%re("/^-+/g"), "")
    ->replaceAllRegExp(%re("/-+$/g"), "")

}