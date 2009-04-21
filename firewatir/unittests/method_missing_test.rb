# feature tests for method missing
# revision: $Revision: 1.0 $

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_MethodMissing < Test::Unit::TestCase

  def setup
    goto_page("table1.html")
  end
  
  def test_MethodNotFound
	assert_raise NoMethodError do
		browser.table(:id, 't1').no_such_method
	end
  end

end
