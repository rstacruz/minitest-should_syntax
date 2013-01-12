require File.expand_path('../helper', __FILE__)

module MiniTest::ArrayMatcher
  def like(right)
    super  unless left.is_a?(Array) && right.is_a?(Array)
    if positive?
      test.assert_equal left.sort, right.sort
    else
      test.refute_equal left.sort, right.sort
    end
  end
end

MiniTest::ShouldSyntax.add MiniTest::ArrayMatcher

describe "Extensions" do
  it ".should.be.like" do
    a = %w(a b c)
    b = %w(b c a)

    a.should.be.like b
  end

  it ".should.not.be.like" do
    a = %w(a b c)
    b = %w(b c A)

    a.should.not.be.like b
  end

  it "super" do
    a = %w(a b c)
    b = 2

    should.raise(NoMethodError) { a.should.be.like b }
  end
end
