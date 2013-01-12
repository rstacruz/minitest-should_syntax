require File.expand_path('../helper', __FILE__)

class IncludeTest < UnitTest
  def test_should_include
    "abc".should.include "b"
  end

  def test_should_include_fail
    self.expects(:assert_includes).with { |a, b| a == "axxc" && b == "b" }
    "axxc".should.include "b"
  end
end
