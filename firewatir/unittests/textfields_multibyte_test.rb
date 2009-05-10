# feature tests for Multibyte characters for Text Fields

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_Fields_Multibyte < Test::Unit::TestCase
    
    def setup
        goto_page("textfields_multibyte.html")
    end
    
    def test_text_field_multibyte_verify_contains
        assert(browser.text_field(:name, "verify").verify_contains("こんにちは"))  
        assert(browser.text_field(:name, "verify").verify_contains(/こん(にち|ばん)は/))  
        assert_false(browser.text_field(:name, "verify").verify_contains("おはよう"))  
        assert_false(browser.text_field(:name, "verify").verify_contains(/おはよう/))  
    end
    
    def test_text_field_get_contents
        assert_equal("こんにちは", browser.text_field(:name, "contents").value)  
    end
    
    tag_method :test_text_field_to_s, :fails_on_ie
    def test_text_field_to_s
        expected = [
            "name:         expected",
            "type:         text",
            "id:           ",
            "value:        こんにちは",
            "disabled:     false", 
            #"style:        ",
            #"  for:        ",
            "read only:    false",
            "max length:   500",
            "length:       0"
        ]
        assert_equal(expected, browser.text_field(:name, "expected").to_s)
    end
    
    def test_text_field_append
        browser.text_field(:name, "append").append(" さようなら")
        assert_equal("こんにちは さようなら", browser.text_field(:name, "append").value)  
    end
    
    def test_text_field_set
        browser.text_field(:name, "set").set("ファイアーウォーター")
        assert_equal("ファイアーウォーター", browser.text_field(:name, "set").value)  
    end

    def test_text_field_assign
        browser.text_field(:name, "assign").value = "ファイアーウォーター"
        assert_equal("ファイアーウォーター", browser.text_field(:name, "assign").value)  
    end
    
    def test_text_field_properties
        assert_equal("こんにちは" , browser.text_field(:name, "properties").value)
    end

end
