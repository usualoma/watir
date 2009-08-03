# feature tests for finding elements by multibyte characters
# revision: $Revision: 1.0 $

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_Element_Find_Multibyte < Test::Unit::TestCase
    def setup()
        goto_page("element_find_multibyte_test.html")
    end

    def test_elements_xpath
      # TODO: The finding by regular expression is not correct.
      #elements = browser.elements_by_xpath("//a[contains(.,/テスト/i)]")
      #assert_equal(2, elements.length)
      #elements.each do |e|
      #  assert_class(e, 'Link')
      #end
      #elements = browser.elements_by_xpath("//a[contains(.,/テスト１/i)]")
      #assert_equal(1, elements.length)
      #elements.each do |e|
      #  assert_class(e, 'Link')
      #end
      #elements = browser.elements_by_xpath("//a[contains(.,/なし/i)]")
      #assert_equal(0, elements.length)

      elements = browser.elements_by_xpath("//a[contains(.,'テスト')]")
      assert_equal(2, elements.length)
      elements.each do |e|
        assert_class(e, 'Link')
      end
      elements = browser.elements_by_xpath("//a[contains(.,'テスト１')]")
      assert_equal(1, elements.length)
      elements.each do |e|
        assert_class(e, 'Link')
      end
    end

    def test_element_xpath
      element = browser.element_by_xpath("//a[contains(.,/テスト/i)]")
      assert_class(element, 'Link')
      element = browser.element_by_xpath("//a[contains(.,'テスト')]")
      assert_class(element, 'Link')
    end

    def test_find_link_by_xpath
      assert(browser.link(:xpath , "//a[contains(.,'テスト')]").exists?)
      assert(browser.link(:xpath, "//a[contains(., /テスト/i)]").exists?)
      assert_false(browser.link(:xpath , "//a[contains(.,'なし')]").exists?)
      assert_false(browser.link(:xpath , "//a[@url='なし']").exists?)
    end

    def test_find_link_by_name
      assert(browser.link(:name, "名前１").exists?)
      assert(browser.link(:name, /名前１/).exists?)
      assert_false(browser.link(:name , "名前なし").exists?)
      assert_false(browser.link(:name , /名前なし/).exists?)
    end

    def test_find_link_by_id
      assert(browser.link(:id , "リンク１").exists?)
      assert(browser.link(:id , /リンク１/).exists?)
      assert_false(browser.link(:id , "リンクなし").exists?)
      assert_false(browser.link(:id , /リンクなし/).exists?)
    end

    def test_find_button_by_value
      assert(browser.button(:value , "ボタン１").exists?)
      assert(browser.button(:value , /ボタン１/).exists?)
      assert_false(browser.button(:value , "ボタンなし").exists?)
      assert_false(browser.button(:value , /ボタンなし/).exists?)
    end
end
