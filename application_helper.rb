require "spec"
require "watir"

module ApplicationHelper

  def open_browser_at url
    @browser = Watir::Browser.new
    set_browser_for_rspec
    @browser.goto url
    @browser.maximize
  end

  def close_browser
    set_browser_for_rspec
    @browser.close
  end

  def set_browser_for_rspec
    options[:browser] = @browser
  end

  def formatter
    @formatter ||= Spec::Runner.options.formatters.find {|f| f.kind_of?(WatirHtmlFormatter)}
  end
end