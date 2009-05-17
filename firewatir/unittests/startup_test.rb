require 'benchmark'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') if $0 == __FILE__
require 'unittests/setup'

class TC_StartupTest < Test::Unit::TestCase
    include FireWatir
    
    def setup
        browser.close
    end

    def test_browser_starts_as_soon_as_jssh_connection_can_be_made
        startup_time = Benchmark.measure { @ff = Firefox.new() }.real
        assert startup_time < 2
    end

    def teardown
      @ff.close
    ensure
      browser = Firefox.new
    end
end
