require "spec"
require "watir"

describe "Some functionality" do

  before :all do
    setup
  end

  it "does something useful" do
    # does something
    check_for_errors
  end

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