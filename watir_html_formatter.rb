require 'spec/runner/formatter/html_formatter'
require 'win32screenshot'
require 'rmagick'
require 'pathname'
require 'fileutils'

class WatirHtmlFormatter < Spec::Runner::Formatter::HtmlFormatter

  def initialize(options, output)
    raise "output has to be a file path!" unless output.is_a?(String)
    @output_dir = File.dirname(output)
    @files_dir = File.join(@output_dir, "files")
    FileUtils.mkdir_p(@files_dir) unless File.exists?(@files_dir)
    $formatter = self
    super
  end

  def example_started(example)
    @files_saved_during_example = []
    super
  end

  def extra_failure_content(failure)
    save_html
    save_screenshot

    content = []
    content << "<span>"
    @files_saved_during_example.each {|f| content << link_for(f)}
    content << "</span>"
    super + content.join($/)
  end

  def link_for(file)
    return unless File.exists?(file[:path])

    description = file[:desc] ? file[:desc] : File.extname(file[:path]).upcase[1..-1]
    path = Pathname.new(file[:path])
    "<a href='#{path.relative_path_from(Pathname.new(@output_dir))}'>#{description}</a>&nbsp;"
  end

  def save_html
    begin
      html = $browser.html
      file_name = file_path("browser.html")
      File.open(file_name, 'w') {|f| f.puts html}
    rescue => e
      $stderr.puts "saving of html failed: #{e.message}"
      $stderr.puts e.backtrace
    end
    file_name
  end

  def save_screenshot(description="Screenshot")
    begin
      $browser.bring_to_front
      width, height, blob = Win32::Screenshot.capture_hwnd($browser.hwnd)
      file_name = file_path("screenshot.png", description)
      img = Magick::ImageList.new
      img.from_blob(blob)
      img.write(file_name)
    rescue => e
      $stderr.puts "saving of screenshot failed: #{e.message}"
      $stderr.puts e.backtrace
    end
    file_name
  end
  
  def file_path(file_name, description=nil)
    extension = File.extname(file_name)
    basename = File.basename(file_name, extension)
    file_path = File.join(@files_dir, "#{basename}_#{Time.now.strftime("%H%M%S")}_#{example_group_number}_#{example_number}#{extension}")
    @files_saved_during_example.unshift(:desc => description, :path => file_path)
    file_path
  end

  def native_file_path(path)
    File::ALT_SEPARATOR ? path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) : path
  end

  def absolute_file_path(file_name, description=nil)
    native_file_path(File.expand_path(file_path(file_name, description)))
  end

end