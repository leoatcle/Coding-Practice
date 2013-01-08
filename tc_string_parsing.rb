require "./string_parsing"
require "test/unit"

class TestStringParsing < Test::Unit::TestCase
  $standard = {:method=>:GET, :path=>"/", :version=>"1.1"}
  def test_parsing
    assert_equal($standard, StringParsing.new.parse_request_line("GET / HTTP/1.1"))
  end
  def test_parsing_reg
    assert_equal($standard, StringParsing.new.parse_request_line_reg("GET / HTTP/1.1"))
  end
end