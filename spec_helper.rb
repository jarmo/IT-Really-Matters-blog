module SpecHelper

  def open_browser_at url
    @browser = Watir::Browser.new
    formatter.browser = @browser rescue nil
    @browser.goto url
    @browser.maximize
  end

  def formatter
    @formatter ||= Spec::Runner.options.formatters.find {|f| f.kind_of?(WatirHtmlFormatter) rescue false}
  end

  def file_path(file_name, description=nil)
    if formatter.respond_to?(:file_path)
      formatter.file_path(file_name, description)
    else
      extension = File.extname(file_name)
      basename = File.basename(file_name, extension)
      file_path = File.join(File.dirname(__FILE__), "#{basename}_#{Time.now.strftime("%H%M%S")}_#{extension}")
      file_path
    end
  end

  def absolute_file_path(file_name, description=nil)
    native_file_path(File.expand_path(file_path(file_name, description)))
  end

  def native_file_path(path)
    File::ALT_SEPARATOR ? path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) : path
  end

  def method_missing(name, *args)
    @browser.respond_to?(name) ? @browser.send(name, *args) : super
  end

  def p(*args)
    @browser.p *args
  end
end

Spec::Runner.configure do |config|
  config.include(SpecHelper)
  config.before(:all) {@browser = Watir::Browser.new}
  config.after(:all) {@browser.close}
end