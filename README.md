# minitest-should_syntax

Rspec-like matching for MiniTest.

*minitest-should_syntax* lets you use a syntax similar to RSpec on your MiniTest 
tests.  It monkey-patches Object to translate RSpec-like sugar into plain 
MiniTest `assert` matchers.

(*Ouch! Monkey patch?* Yes! But it only defines `Object#should` and 
 `#should_not`.)

```
$ gem install minitest-should_syntax
```

## Basic usage

``` ruby
require 'minitest/autorun'
require 'minitest/should_syntax'

describe "Books" do
  it "should work" do
    book = Book.new title: "Revolution"

    book.title.should == "Revolution"
  end
end

```

## Should

Then you may use it as so:

```ruby
obj.should == 2                    # => assert_equal 2, obj
obj.should =~ /regex/              # => assert_match /regex/, obj
obj.should != 3                    # => assert_not_equal 3, obj
obj.should.nil                     # => assert_nil obj
obj.should.respond_to(:freeze)     # => assert_respond_to obj, :freeze 

# Note that .be, .a and .an are optional.
obj.should.nil                     # => assert_nil obj
obj.should.be.nil                  # => assert_nil obj
obj.should.be.a.nil                # => assert_nil obj

# You can also use should_not, or should.not:
obj.should_not == 3
obj.should.not == 3
obj.should_not.be.nil

# Anything else will pass through with a ?:
obj.should.be.good_looking         # => assert obj.good_looking?

should.raise(Error) { lol }
should_not.raise { puts "hi" }

# You may add messages to your asserts with #blaming or #messaging.
(2 + 2).should.blaming("weird math") == 4
```

## Wrapped assertions

These are based from MiniTest::Assertions.

| Test::Unit                  | MiniTest::ShouldSyntax                |
|-----------------------------|---------------------------------------|
| assert_equal                | should.equal, should ==               |
| assert_not_equal            | should.not.equal, should.not ==       |
| assert_same                 | should.be                             |
| assert_not_same             | should.not.be                         |
| assert_nil                  | should.be.nil                         |
| assert_not_nil              | should.not.be.nil                     |
| assert_in_delta             | should.be.close                       |
| assert_match                | should.match, should =~               |
| assert_no_match             | should.not.match, should.not =~       |
| assert_instance_of          | should.be.an.instance_of              |
| assert_kind_of              | should.be.a.kind_of                   |
| assert_respond_to           | should.respond_to                     |
| assert_raise                | should.raise                          |
| assert_nothing_raised       | should.not.raise                      |
| assert_throws               | should.throw                          |
| assert_block                | should.satisfy                        |

## Messages

Use the `msg` helper:

``` ruby
it "should work" do
  book = Book.new title: "Pride & Prejudice"

  msg "The title should've been set on constructor."
  book.title.should == "Pride & Prejudice"
end
```

Or you can use `.blaming` which does the same thing (with a more cumbersome 
    syntax):

``` ruby
it "should work" do
  book = Book.new title: "Pride & Prejudice"

  message = "The title should've been set on constructor."
  book.title.should.blaming(message) == "Pride & Prejudice"
end
```

## Extending

Need to create your own matchers? Create your new matcher in a module, then use 
`MiniTest::ShouldSyntax.add`.

```ruby
module DanceMatcher
  def boogie_all_night!
    # Delegates to `assert(condition, message)`.
    #
    #   positive?   - returns `true` if .should, or `false` if .should.not
    #   test        - the MiniTest object
    #   msg         - the failure message. `nil` if not set
    #
    if positive?
      test.assert left.respond_to?(:dance), msg
    else
      test.refute left.respond_to?(:dance), msg
    end
  end
end

MiniTest::ShouldSyntax.add DanceMatcher

# Then in your tests, use:
dancer.should.boogie_all_night!
```

