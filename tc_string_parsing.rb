require "./string_parsing"
require "test/unit"

class TestStringParsing < Test::Unit::TestCase
  def test_parsing
    assert_same('{:method=>:GET, :path=>"http://d", :version=>"1.1"}', StringParsing.new.parse_request_line("GET / HTTP/1.1"))
  end
  def test_parsing_reg
    assert_same('{:method=>:GET, :path=>"http://d", :version=>"1.1"}', StringParsing.new.parse_request_line_reg("GET / HTTP/1.1"))
  end
end