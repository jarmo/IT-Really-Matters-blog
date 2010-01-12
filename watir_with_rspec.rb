require 'watir'
require 'spec'

describe "Google" do

  before :all do
    $browser = Watir::Browser.new
    $browser.maximize
    $browser.goto "http://google.com"
  end

  it "has word 'Google' on main page" do
    $browser.text.should include("Google")
  end

  it "has word 'Bing' as it's title" do
    $browser.title.should == "Bing"
  end

  it "uses formatter's file_path method and fails" do
    file1 = $formatter.file_path("file1.txt")
    File.open(file1, 'w') {|f| f.puts "content for file1"}

    file2 = $formatter.file_path("file2.txt", "Description for file2")
    File.open(file2, 'w') {|f| f.puts "content for file2, with description"}
    raise "spec fails!"
  end

  it "saves Watir 'Install' image" do
    $browser.goto "http://www.watir.com"
    image_path = $formatter.absolute_file_path("watir-install-logo.png")
    $browser.image(:title => 'Install').save(image_path)
    raise "spec fails again!"
  end

  after :all do
    $browser.close
  end

end