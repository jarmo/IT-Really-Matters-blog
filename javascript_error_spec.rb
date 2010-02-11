require 'watir'
require 'spec'

module PageCheckers
  JAVASCRIPT_ERRORS_CHECKER = lambda {|ie| raise "Got JavaScript error!" if ie.status =~ /Error on page/}
end

describe "Javascript error" do

  before :all do
    $browser = Watir::Browser.new
    $browser.add_checker PageCheckers::JAVASCRIPT_ERRORS_CHECKER
    $browser.maximize
    $browser.goto "http://dl.dropbox.com/u/2731643/blog/javascript_page.html"
  end

  it "fails and makes a screenshot of JavaScript error dialog" do
    $browser.link(:id => 'mylink').click
    raise "failing!" # to trigger failure and make a screenshot of JavaScript error
  end

  after :all do
    $browser.close
  end

end