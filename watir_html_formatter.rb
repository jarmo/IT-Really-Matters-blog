require 'spec/runner/formatter/html_formatter'
require 'win32screenshot'
require 'rmagick'
require 'pathname'

class WatirHtmlFormatter < Spec::Runner::Formatter::HtmlFormatter

  def initialize(options, output)
    raise "output has to be a file path!" unless output.is_a?(String)
    @output_dir = File.dirname(output)
    @files_dir = File.join(@output_dir, "files")
    super
  end

  def extra_failure_content(failure)
    content = []
    content << "<span>"
    file_name = save_html
    content << link_for(file_name) if file_name && File.exists?(file_name)
    
    file_name = save_screenshot
    content << link_for(file_name) if file_name && File.exists?(file_name)

    content << "</span>"
    super + content.join($/)
  end

  def link_for(file_name)
    description = File.extname(file_name).upcase[1..-1]

    path = Pathname.new(file_name)
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

  def save_screenshot
    begin
      $browser.bring_to_front
      width, height, blob = Win32::Screenshot.capture_hwnd($browser.hwnd)
      file_name = file_path("screenshot.png")
      img = Magick::ImageList.new
      img.from_blob(blob)
      img.write(file_name)
    rescue => e
      $stderr.puts "saving of screenshot failed: #{e.message}"
      $stderr.puts e.backtrace
    end
    file_name
  end
  
  def file_path(file_name)
    extension = File.extname(file_name)
    basename = File.basename(file_name, extension)
    file_path = File.join(@files_dir, "#{basename}_#{Time.now.strftime("%H%M%S")}_#{example_group_number}_#{example_number}#{extension}")
    file_path
  end

end