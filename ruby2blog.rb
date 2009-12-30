require 'rubygems'
require 'syntax/convertors/html'

BACKGROUND_COLOR = '#2B2B2B'
COLOR = '#E6E1DC'
COLORS = {
  :keyword => '#FF6600',
  :symbol => '#6E9CBE',
  :constant => '#339999',
  :attribute => '#D0D0FF',
  :string => '#66FF00',
  :number => '#CCFF33',
  :comment => '#9933CC',
  :method => '#FFCC00',
  :ident => '#FFFFFF',
  :escape => '#555555',
  :expr => '#CCCC33',
  :regex => '#44B4CC',
  :class => '#FFFFFF;text-decoration:underline'
}

html = Syntax::Convertors::HTML.for_syntax('ruby').convert(File.read(ARGV[0]))

COLORS.each do |token, color|
  html.gsub!(%Q{class="#{token}"}, %Q{style="color:#{color}"})
end

puts %Q(<pre style="background-color:#{BACKGROUND_COLOR};color:#{COLOR};padding:6px;overflow:auto;line-height:12px;font-size:12px;padding:6px;"><code>#{html}</code></pre>)


