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
      #
      # This test relies upon you having version 0.95 of the JSSH plugin installed.
      # This can be installed from the plugins folder in: http://github.com/ajcollins/JSSH-XPIs/tree/master
      # 
      # You need to create a profile named 'port9998' for this to work, 
      # and then install the JSSH XPI into this profile.
      #
      # You will also need TCP port 9998 to be unused by anything else on your system.
      #
      options = { :multiple_browser_xpi => true, :port => 9998, :profile => 'port9998' }
      browser2 = FireWatir::Firefox.new(options)
      
      browser2.goto(browser.url)
      assert_equal(browser.html, browser2.html)
      
      browser2.goto(self.class.html_root + "cssTest.html")
      assert_not_equal(browser.html, browser2.html)
      
      browser2.close
    end
end
