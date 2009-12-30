require 'watir'

# test that word "Google" appears on Google's main page
browser = Watir::Browser.new

begin
  browser.goto "http://google.com"

  if browser.text.include?("Google")
    puts "Test passed!"
  else
    puts "Test failed!"
  end

  # failing test
  if browser.title == "Bing"
    puts "Test passed!"
  else
    puts "Test failed!"
  end
ensure
  browser.close
end