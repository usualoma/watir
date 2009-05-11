# feature tests for attaching to new Firefox windows
# revision: $Revision: 1.0 $

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_MultipleBrowsers < Test::Unit::TestCase
    tags :fails_on_ie

    def setup
      goto_page("new_browser.html")
    end

    def test_multiple_browsers
      options = { :multiple_browser_xpi => true, :port => 9998, :profile => 'port9998' }
      browser2 = FireWatir::Firefox.new(options)
      browser2.goto(browser.url)
      assert_equal(browser.html, browser2.html)
      browser2.goto("http://news.bbc.co.uk")
      assert_not_equal(browser.html, browser2.html)
      browser2.close
    end
end
