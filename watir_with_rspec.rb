require 'watir'
require 'spec'

describe "Google" do

  before :all do
    @browser = Watir::Browser.new
    @browser.goto "http://google.com"
  end

  it "has word 'Google' on main page" do
    @browser.text.should include("Google")
  end

  it "has word 'Bing' as it's title" do
    @browser.title.should == "Bing"
  end

  after :all do
    @browser.close
  end

end