# spec/support/utils.rb
module Utils
  def self.set_browser_date(page, year, month, day)
    page.execute_script <<~JS
      Date = class extends Date {
        constructor(...args) {
          if (args.length === 0) {
            return new window.Date(#{year}, #{month - 1}, #{day});
          }
          return new window.Date(...args);
        }
      }
    JS
  end
end