require File.expand_path('../helper', __FILE__)

describe "Includes" do
  it ".should.include" do
    "abc".should.include "b"
  end

  it ".should.include failure" do
    self.expects(:assert_includes).with { |a, b| a == "axxc" && b == "b" }
    "axxc".should.include "b"
  end
end
