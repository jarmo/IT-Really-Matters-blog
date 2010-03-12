module MyHelpers
  def setup
    open_browser_at "http://example.com"
    log_in
  end

  def open_browser_at url
    @browser = Watir::Browser.new
    @browser.maximize
    @browser.goto url
  end

  def log_in
    @browser.text_field(:id => "user").set "my_username"
    @browser.text_field(:id => "password").set "my_password"
    @browser.button(:id => "login_button").click
  end

  def check_for_errors
    @browser.div(:id => "errors").should_not exist
  end
end

require "spec"
require "watir"

describe "My behaviour" do
 include MyHelpers

 # rest of the spec...
end