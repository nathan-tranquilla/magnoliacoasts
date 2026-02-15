// Utility functions for banner date checking - used in SSR
// Parse date string "MM-DD" with current year
let parseDate = (dateStr: string): option<Date.t> => {
  let parts = dateStr->String.split("-")->Array.map(str => Belt.Int.fromString(str))
  switch (parts[0], parts[1]) {
  | (Some(Some(month)), Some(Some(day))) => {
      let currentYear = Date.make()->Date.getFullYear
      Some(Date.makeWithYMD(~year=currentYear, ~month, ~day))
    }
  | _ => None
  }
}

// Check if current date is in range
let isCurrentInRange = (current: Date.t, start: Date.t, end_: Date.t): bool => {
  current->Date.compare(start) >= 0. && current->Date.compare(end_) <= 0.
}

// Check if a banner message should be displayed based on current date
let shouldShowBanner = (startDate: string, endDate: string): bool => {
  let currentDate = Date.make()
  switch (parseDate(startDate), parseDate(endDate)) {
  | (Some(start), Some(end_)) => isCurrentInRange(currentDate, start, end_)
  | _ => false
  }
}
