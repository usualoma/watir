TOPDIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift TOPDIR
require 'unittests/setup'

Dir.chdir TOPDIR do
  $all_tests.sort.each_with_index {|x, i| require x }
end
