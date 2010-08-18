require "require_all"
require "watir"
require "spec"
# require some other gem

# load all non-spec ruby files
spec_dir = File.join(File.dirname(__FILE__), "spec/**/*.rb")
filtered_ruby_files = Dir.glob(spec_dir).delete_if do |file|
  File.basename(file) =~ /.*_spec\.rb$/
end
require_all filtered_ruby_files unless filtered_ruby_files.empty?