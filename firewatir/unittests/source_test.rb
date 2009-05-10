# feature tests for Source
# revision: $Revision: 1.0 $

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_Source < Test::Unit::TestCase

  def test_get_html_source
    goto_page("source1.html")
    @source1 = browser.source
    @check1 ="This is a html tagged page, its great.\n<B> Some bold letters </B>"
    assert_match(@check1, @source1)
  end

  def test_get_non_html_source
    goto_page("source2.html")
    @source2= browser.source
    @check2 = "<TAG html=\"not\">\nThis is a not html tagged page.\n</TAG>"
    assert_match(@check2, @source2)
  end
end
